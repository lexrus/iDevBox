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
import iDevBoxKit

class FormatJSONCommand: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        let lines = invocation.buffer.lines

        // FIXME: We should format the completeBuffer when nothing selected. Otherwise try format selection first.
        let sourceString = invocation.buffer.completeBuffer

        do {
            let formattedJSONString = try JSONFormatter.format(sourceString)
            lines.removeAllObjects()
            lines.addObjects(from: [formattedJSONString])
            completionHandler(nil)
        } catch {
            completionHandler(error)
        }
    }
    
}
