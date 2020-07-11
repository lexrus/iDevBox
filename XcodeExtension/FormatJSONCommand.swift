//
//  FormatJSONCommand.swift
//  XcodeExtension
//
//  Created by Lex on 2020/7/11.
//  Copyright © 2020 Lex. All rights reserved.
//

import Foundation
import XcodeKit

enum FormatJSONError : Error {
    case bufferError
    case invalidJSON
    case invalidData
}

class FormatJSONCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        let lines = invocation.buffer.lines

        do {
            // FIXME: We should format the completeBuffer when nothing selected. Otherwise try format selection first.
            guard let data = invocation.buffer.completeBuffer.data(using: .utf8, allowLossyConversion: true) else {
                completionHandler(FormatJSONError.bufferError)
                return
            }

            let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments, .mutableLeaves])
            let formattedData = try JSONSerialization.data(withJSONObject: json, options: [.fragmentsAllowed, .prettyPrinted])
            guard let formattedString = String(data: formattedData, encoding: .utf8) else {
                completionHandler(FormatJSONError.invalidData)
                return
            }

            lines.removeAllObjects()
            lines.addObjects(from: [formattedString])

            completionHandler(nil)
        } catch {
            completionHandler(error)
        }
    }
    
}
