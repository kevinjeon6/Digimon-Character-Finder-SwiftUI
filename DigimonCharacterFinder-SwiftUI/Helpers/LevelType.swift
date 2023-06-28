//
//  LevelType.swift
//  DigimonCharacterFinder-SwiftUI
//
//  Created by Kevin Mattocks on 6/28/23.
//

import Foundation

enum LevelType: String, Identifiable, CaseIterable {
    
    case all
    case inTraining
    case rookie
    case champion
    case ultimate
    case mega
    case fresh
    case armor
    
    var id: String {
        self.rawValue
    }
    
    var levelName: String {
        switch self {
        case .all:
            return "All"
        case .inTraining:
            return "In Training"
        case .rookie:
            return "Rookie"
        case .champion:
            return "Champion"
        case .ultimate:
            return "Ultimate"
        case .mega:
            return "Mega"
        case .fresh:
            return "Fresh"
        case .armor:
            return "Armor"
        }
    }
    
    

}
