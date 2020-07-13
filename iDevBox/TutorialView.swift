//
//  TutorialView.swift
//  iDevBox
//
//  Created by Lex on 2020/7/13.
//  Copyright © 2020 Lex. All rights reserved.
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("How To Use?")
                .font(.title)
                .padding()

            VStack(alignment: .leading, spacing: 10) {
                Text("1. Open System Preferences")
                Text("2. Open Extensions")
                Text("3. Restart Xcode")
                Text("4. Editor -> iDevBox")
            }.font(.subheadline)
        }
        .tabItem {
            Text("Tutorial")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
