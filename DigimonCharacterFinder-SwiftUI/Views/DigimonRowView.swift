//
//  DigimonRowView.swift
//  DigimonCharacterFinder-SwiftUI
//
//  Created by Kevin Mattocks on 6/25/23.
//

import SwiftUI

struct DigimonRowView: View {
    
    // MARK: - Properties
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
            } label: {
                Image(systemName: isFavorited ? "star.fill" : "star")
                    .font(.title2)
            }

        }
        .padding(.horizontal)
    }
}

struct DigimonRowView_Previews: PreviewProvider {
    static var previews: some View {
        DigimonRowView(digiInfo: Digimon.digimonExample)
    }
}
