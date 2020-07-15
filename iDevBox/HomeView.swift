//
//  HomeView.swift
//  iDevBox
//
//  Created by Lex on 2020/7/11.
//  Copyright © 2020 Lex. All rights reserved.
//

import AppKit
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            SideBar()

            TutorialView()
        }
        .frame(minWidth: 500, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
