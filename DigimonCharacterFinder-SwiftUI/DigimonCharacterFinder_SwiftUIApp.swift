//
//  DigimonCharacterFinder_SwiftUIApp.swift
//  DigimonCharacterFinder-SwiftUI
//
//  Created by Kevin Mattocks on 6/14/23.
//

import SwiftUI

@main
struct DigimonCharacterFinder_SwiftUIApp: App {
    
    // MARK: - Properties
    @StateObject private var viewModel = DigimonViewModel()
    @StateObject private var dataController = DataController()
   

    var body: some Scene {
        WindowGroup {
           TabBarView()
                .environmentObject(viewModel)
                .environmentObject(dataController)
        }
    }
}
