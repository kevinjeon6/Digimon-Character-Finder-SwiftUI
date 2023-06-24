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
