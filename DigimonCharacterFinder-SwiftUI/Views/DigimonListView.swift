//
//  ContentView.swift
//  DigimonCharacterFinder-SwiftUI
//
//  Created by Kevin Mattocks on 6/14/23.
//

import SwiftUI
import CoreData

struct DigimonListView: View {
    
    // MARK: - Properties
    @StateObject var viewModel = DigimonViewModel()


    // MARK: - Body
    var body: some View {
        NavigationStack {
            List(viewModel.characters, id: \.self) {
                info in
                
                DigimonRowView(digiInfo: info)

            }
            .listStyle(.plain)
            .navigationTitle("Digimon")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                try? await viewModel.getDigimonData()
            }
        }
        .searchable(text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search for a Digimon"
                    
        )
    }
    
    
    // MARK: - Nav Bar Color
    //SwiftUI doesn't have an API to modify the appearance of the navigation bar, so you have to fall back on UIKit's UInavigationBarAppearance to configure it's appearance
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(Color.blue)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .systemBackground
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black

        let cancelButton = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButton, for: .normal)

        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

    }
}


struct DigimonListView_Previews: PreviewProvider {
    static var previews: some View {
        DigimonListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
