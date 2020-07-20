//
//  FormatJSON.swift
//  iDevBox
//
//  Created by Lex on 2020/7/13.
//  Copyright © 2020 Lex. All rights reserved.
//

import SwiftUI
import iDevBoxKit

enum FormatEngine: String, CaseIterable {
    case javaScriptCore = "JavaScriptCore"
    case jsonSerializer = "JSONSerializer"
}

struct FormatJSON: View {
    @State var currentEngine: FormatEngine = .javaScriptCore

    var body: some View {
        VStack {
            Text("Format JSON")
                .font(.title)
                .fontWeight(.bold)

            ForEach(FormatEngine.allCases, id: \.self) { engine in
                CheckBox(label: engine.rawValue, isMarked: self.currentEngine == engine) {
                    self.currentEngine = engine
                    Settings.useJavaScriptCore = engine == .javaScriptCore
                }
            }
        }
        .tabItem {
            Text("Format JSON")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CheckBox: View {
    private let isMarked: Bool
    private let label: String
    private let callback: () -> Void

    init(label: String, isMarked: Bool = false, callback: @escaping () -> Void) {
        self.label = label
        self.callback = callback
        self.isMarked = isMarked
    }

    var body: some View {
        Button(action: callback) {
            HStack(alignment: .center, spacing: 10) {
                ZStack {
                    Circle()
                        .strokeBorder(isMarked ? Color.blue : Color.primary)
                    if isMarked {
                        Circle()
                            .foregroundColor(Color.blue)
                            .frame(maxWidth: 13)
                            .shadow(color: Color.blue, radius: 3, x: 0, y: 0)
                    }
                }.frame(maxWidth: 24, maxHeight: 24)

                Text(label)
                    .font(.body)
                    .foregroundColor(isMarked ? .blue : .primary)
                    .frame(maxHeight: 30)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .buttonStyle(PlainButtonStyle())
    }
}

struct FormatJSON_Previews: PreviewProvider {
    static var previews: some View {
        FormatJSON()
    }
}
