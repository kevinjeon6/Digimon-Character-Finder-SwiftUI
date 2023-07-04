//
//  DigimonViewModel.swift
//  DigimonCharacterFinder-SwiftUI
//
//  Created by Kevin Mattocks on 6/19/23.
//

import Foundation

@MainActor
class DigimonViewModel: ObservableObject {
    
    @Published var characters = [Digimon]()
    @Published var searchText = ""
    @Published var filterStatus = LevelType.all
    
    var searchResults: [Digimon] {
        if searchText.isEmpty {
            return characters
        } else {
            return characters.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    //Filter list based on picker
    
    var filterResults: [Digimon] {
        if filterStatus == .all {
            return searchResults
        } else {
            return characters.filter{ $0.level == filterStatus.levelName}
        }
    }
    
    init() {
        
        Task {
            self.characters = try await DigimonNetworkManager.getDigimonData()
        }
    }
    
    
}
