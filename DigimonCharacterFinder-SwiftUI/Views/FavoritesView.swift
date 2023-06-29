//
//  FavoritesView.swift
//  DigimonCharacterFinder-SwiftUI
//
//  Created by Kevin Mattocks on 6/28/23.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var moc: DataController
    
    
    var body: some View {
        NavigationStack {
            
            if moc.savedEntities.isEmpty {
                Text("You do not have any favorites yet! Start adding!")
                    .navigationTitle("Favorites")
                    .navigationBarTitleDisplayMode(.inline)
                
                Image("digimon-logo")
                    .resizable()
                    .frame(width: 270, height: 150)
            } else {
                List {
                    ForEach(moc.savedEntities) { digimon in
                        HStack {
                            AsyncImage(url: URL(string: digimon.img ?? "N/A")) {
                                phase in
                                
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } else if phase.error != nil {
                                    Text("Couldn't upload")
                                } else {
                                    ProgressView()
                                }
                            }
                            .frame(width: 100, height: 100)
                            
                            VStack(alignment: .leading) {
                                Text(digimon.name ?? "Unknown Name")
                                Text(digimon.level ?? "Unknown Level")
                            }
                        }
                    }
                    .onDelete(perform: moc.deleteItem)
                }
                .listStyle(.plain)
                .navigationTitle("Favorites")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
