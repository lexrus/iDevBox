//
//  SideBar.swift
//  iDevBox
//
//  Created by Lex on 2020/7/13.
//  Copyright © 2020 Lex. All rights reserved.
//

import SwiftUI

struct SideBar: View {

    var body: some View {
        List {
            NavigationLink(destination: TutorialView()) {
                Text("How to use?")
            }
            NavigationLink(destination: FormatJSON()) {
                Text("Format JSON")
            }
        }
        .lineSpacing(15)
        .listStyle(SidebarListStyle())
        .frame(minWidth: 150, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
        .padding(.top, 15)
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        SideBar()
    }
}
