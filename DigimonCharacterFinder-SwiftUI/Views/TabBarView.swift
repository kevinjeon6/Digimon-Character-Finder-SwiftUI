//
//  TabBarView.swift
//  DigimonCharacterFinder-SwiftUI
//
//  Created by Kevin Mattocks on 6/28/23.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            DigimonListView()
                .tabItem {
                    Label("Digmon", systemImage: "list.dash")
                }
                .tag(0)
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
                .tag(1)
            
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(DigimonViewModel())
    }
}
