//
//  DigimonError.swift
//  DigimonCharacterFinder-SwiftUI
//
//  Created by Kevin Mattocks on 7/2/23.
//

import Foundation

enum DigimonError: Error {
    case invalidURL
    case serverError
    case invalidData
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "This is a bad URL"
        case .serverError:
            return "Error while fetching the data"
        case .invalidData:
            return "Invalid data retreiving Digimon data."
        case .unknown(let error):
            return error.localizedDescription

        }
    }
}
