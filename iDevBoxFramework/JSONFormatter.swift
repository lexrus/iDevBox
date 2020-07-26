//
//  JSONFormatter.swift
//  iDevBoxKit
//
//  Created by Lex on 2020/7/26.
//  Copyright © 2020 Lex. All rights reserved.
//

import Foundation
import JavaScriptCore

public enum FormatJSONError : Error {
    case bufferError
    case invalidJSON
    case invalidData
    case jsContextFailure
    case failedToFormat
}

public enum FormatEngine {
    case jsonSerializer
    case javaScriptCore
}

public struct JSONFormatter {

    private static var formatEngine: FormatEngine {
        Settings.useJavaScriptCore ? .javaScriptCore : .jsonSerializer
    }

    public static func format(_ string: String, usesTabsForIndentation: Bool = false, indentationWidth: Int = 4) throws -> String?  {
        switch formatEngine {

        // MARK: - JavaScriptCore
        case .javaScriptCore:
            guard let jsContext = JSContext() else {
                throw FormatJSONError.jsContextFailure
            }

            jsContext.setObject(string, forKeyedSubscript: "jsonString" as NSString)

            let indentation = usesTabsForIndentation
                ? "\t"
                : [String](repeating: " ", count: indentationWidth).joined()

            let js = "try{JSON.stringify(JSON.parse(jsonString), null, '\(indentation)')}catch{}"

            guard let result = jsContext.evaluateScript(js), result.isString else {
                throw FormatJSONError.failedToFormat
            }

            return result.toString()

        // MARK: - JSONSerializer
        case .jsonSerializer:
            guard let data = string.data(using: .utf8, allowLossyConversion: true) else {
                throw FormatJSONError.bufferError
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments, .mutableLeaves])
                let formattedData = try JSONSerialization.data(withJSONObject: json, options: [.fragmentsAllowed, .prettyPrinted])
                guard let result = String(data: formattedData, encoding: .utf8) else {
                    throw FormatJSONError.invalidData
                }

                return result
            } catch {
                throw FormatJSONError.invalidData
            }
        }
    }

}
