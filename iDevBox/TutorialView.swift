//
//  TutorialView.swift
//  iDevBox
//
//  Created by Lex on 2020/7/13.
//  Copyright © 2020 Lex. All rights reserved.
//

import SwiftUI

struct TutorialView: View {
    fileprivate func stepView(_ step: Int, _ title: String) -> some View {
        return HStack {
            Text("\(step).")
                .font(.subheadline)
                .frame(minWidth: 15, alignment: .trailing)
            Text(title)
        }
        .padding([.top, .bottom], 7)
        .padding([.leading, .trailing], 15)
        .background(Color.green.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("How To Use?")
                .font(.title)
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 15) {
                stepView(1, "Open System Preferences")
                stepView(2, "Open Extensions")
                stepView(3, "Restart Xcode")
                stepView(4, "Editor -> iDevBox")
            }
            .padding(.top)
            .font(.subheadline)
        }
        .padding()
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
