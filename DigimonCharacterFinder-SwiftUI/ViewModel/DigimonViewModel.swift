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
    
    
    func getDigimonData() async throws {
        
        guard let url = URL(string: "https://digimon-api.vercel.app/api/digimon") else { return print("This is a bad URL")}
        
        let urlRequest = URLRequest(url: url)
        
        do {
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return print("Server error")}
            
            let decoder = JSONDecoder()
            
            self.characters = try decoder.decode([Digimon].self, from: data)
            
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
    }
    
}
