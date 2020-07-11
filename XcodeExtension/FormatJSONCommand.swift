//
//  FormatJSONCommand.swift
//  XcodeExtension
//
//  Created by Lex on 2020/7/11.
//  Copyright © 2020 Lex. All rights reserved.
//

import Foundation
import XcodeKit
import JavaScriptCore

enum FormatJSONError : Error {
    case bufferError
    case invalidJSON
    case invalidData
    case jsContextFailure
    case failedToFormat
}

enum FormatEngine {
    case jsonSerializer
    case javaScriptCore
}

class FormatJSONCommand: NSObject, XCSourceEditorCommand {

    // TODO: Provide as an option
    private var formatEngine: FormatEngine = .javaScriptCore
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        let lines = invocation.buffer.lines

        // FIXME: We should format the completeBuffer when nothing selected. Otherwise try format selection first.
        let sourceString = invocation.buffer.completeBuffer

        let formattedJSONString: String

        switch formatEngine {

        // MARK: - JavaScriptCore
        case .javaScriptCore:
            guard let jsContext = JSContext() else {
                completionHandler(FormatJSONError.jsContextFailure)
                return
            }

            jsContext.setObject(sourceString, forKeyedSubscript: "jsonString" as NSString)

            let indentation = invocation.buffer.usesTabsForIndentation
                ? "\t"
                : [String](repeating: " ", count: invocation.buffer.indentationWidth).joined()

            let js = "try{JSON.stringify(JSON.parse(jsonString), null, '\(indentation)')}catch{}"

            guard let result = jsContext.evaluateScript(js), result.isString else {
                completionHandler(FormatJSONError.failedToFormat)
                return
            }

            formattedJSONString = result.toString()

        // MARK: - JSONSerializer
        case .jsonSerializer:
            guard let data = sourceString.data(using: .utf8, allowLossyConversion: true) else {
                completionHandler(FormatJSONError.bufferError)
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments, .mutableLeaves])
                let formattedData = try JSONSerialization.data(withJSONObject: json, options: [.fragmentsAllowed, .prettyPrinted])
                guard let result = String(data: formattedData, encoding: .utf8) else {
                    completionHandler(FormatJSONError.invalidData)
                    return
                }

                formattedJSONString = result
            } catch {
                completionHandler(FormatJSONError.invalidData)
                return
            }
        }

        lines.removeAllObjects()
        lines.addObjects(from: [formattedJSONString])
        completionHandler(nil)
    }
    
}
