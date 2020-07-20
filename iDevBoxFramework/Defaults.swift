//
//  Defaults.swift
//  iDevBoxFramework
//
//  Created by Lex on 2020/7/18.
//  Copyright © 2020 Lex. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    var useJavaScriptCore: DefaultsKey<Bool> { .init("useJavaScriptCore", defaultValue: true) }
}

public struct Settings {
    @SwiftyUserDefault(keyPath: \.useJavaScriptCore)
    public static var useJavaScriptCore: Bool
}
