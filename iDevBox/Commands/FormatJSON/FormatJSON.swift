//
//  FormatJSON.swift
//  iDevBox
//
//  Created by Lex on 2020/7/13.
//  Copyright © 2020 Lex. All rights reserved.
//

import SwiftUI

struct FormatJSON: View {
    var body: some View {
        VStack {
            Text("Format JSON")
                .font(.title)
            Text("There's no options available yet.")
                .font(.subheadline)
        }
        .tabItem {
            VStack {
                Text("Format JSON")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct FormatJSON_Previews: PreviewProvider {
    static var previews: some View {
        FormatJSON()
    }
}
