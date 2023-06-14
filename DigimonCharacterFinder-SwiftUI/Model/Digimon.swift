//
//  Digimon.swift
//  DigimonCharacterFinder-SwiftUI
//
//  Created by Kevin Mattocks on 6/14/23.
//

import Foundation

struct Digimon: Codable, Hashable {
    
    var name: String
    var img: String
    var level: String
    
    static let digimonExample = Digimon(name: "Agumon", img: "Rookie", level: "https://digimon.shadowsmith.com/img/agumon.jpg")
}
