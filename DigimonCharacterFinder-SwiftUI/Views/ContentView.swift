//
//  ContentView.swift
//  DigimonCharacterFinder-SwiftUI
//
//  Created by Kevin Mattocks on 6/14/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var viewModel = DigimonViewModel()


    var body: some View {
        NavigationStack {
            List(viewModel.characters, id: \.self) {
                info in
                
                HStack {
                    AsyncImage(url: URL(string: info.img)) { phase in
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
                        Text(info.name)
                        Text(info.level)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Digimon")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                try? await viewModel.getDigimonData()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
