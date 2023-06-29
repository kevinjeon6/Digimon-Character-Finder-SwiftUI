//
//  DigimonRowView.swift
//  DigimonCharacterFinder-SwiftUI
//
//  Created by Kevin Mattocks on 6/25/23.
//

import SwiftUI

struct DigimonRowView: View {
    
    // MARK: - Properties
    @EnvironmentObject var moc: DataController
    @State private var isFavorited: Bool = false
    
    var digiInfo: Digimon
    
    
    // MARK: - Body
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: digiInfo.img)) { phase in
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
                Text(digiInfo.name)
                Text(digiInfo.level)
            }
            Spacer()
            Button {
                isFavorited.toggle()
                
                if isFavorited {
                    moc.addItem(character: digiInfo)
                } else {
                    try? moc.deleteFavorite(character: digiInfo)
                }
                
            } label: {
                Image(systemName: isFavorited ? "star.fill" : "star")
                    .font(.title2)
            }

        }
        .padding(.horizontal)
        .onAppear {
            isFavorited = moc.isFavorite(character: digiInfo)
        }
    }
}

struct DigimonRowView_Previews: PreviewProvider {
    static var previews: some View {
        DigimonRowView(digiInfo: Digimon.digimonExample)
    }
}
