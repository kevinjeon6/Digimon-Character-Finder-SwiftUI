//
//  DigimonNetworkManager.swift
//  DigimonCharacterFinder-SwiftUI
//
//  Created by Kevin Mattocks on 7/2/23.
//

import Foundation


final class DigimonNetworkManager {
    

    static func getDigimonData() async throws -> [Digimon] {
        
        guard let url = URL(string: "https://digimon-api.vercel.app/api/digimon") else { throw DigimonError.invalidURL}
        
        let urlRequest = URLRequest(url: url)
        
        do {
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw DigimonError.serverError}
            
            let decoder = JSONDecoder()
            
            guard let characters = try? decoder.decode([Digimon].self, from: data) else { throw DigimonError.invalidData}
            return characters
            
        } catch {
            throw DigimonError.unknown(error)
        }
        
    }
    
}



