//
//  DataController.swift
//  DigimonCharacterFinder-SwiftUI
//
//  Created by Kevin Mattocks on 6/28/23.
//

import CoreData
import Foundation
import SwiftUI


//MVVM with Core Data

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "DigimonCharacterFinder_SwiftUI")
    private let entityName = "DigimonEntity"
    
    @Published var savedEntities = [DigimonEntity]()
    
    
    init() {
        //Load persistent stores when created
        container.loadPersistentStores { description, error in
            if let error {
                print("Core data failed to load \(error.localizedDescription)")
            } else {
                print("Core data successfully loaded")
            }
        }
        
        getFavorites()
    }
    
    // MARK: - Methods
    func getFavorites() {
         //Create the fetch request
         //Need to give a specific result type which is the type we are trying to fetch in this case is DigimonEntity
         //The request is getting all entities in the container
         let request = NSFetchRequest<DigimonEntity>(entityName: entityName)
         
         do {
             //try and fetch from the container and result will be stored and saved in the savedEntities
             savedEntities = try container.viewContext.fetch(request)
         } catch {
             print("Error fetching Digimon Entities")
         }
     }
    
    //Pass in Digimon to function and convert it to an entity
    func addItem(character: Digimon) {
        //When adding, create the entity and provide it some data and then save
        //In this case when getting data from JSON, we Convert Digimon model to entity we want to save
        let entity = DigimonEntity(context: container.viewContext)//container refers to the container we made container = NSPersistentContainer(name: "")
        entity.name = character.name
        entity.level = character.level
        entity.img = character.img
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            getFavorites() //refetchign from the context
        } catch {
            print("Error saving the data to Core Data")
        }
    }
    
    func deleteItem(offsets: IndexSet) {
       //Delete objects here
        //[$0] the first index
       offsets.map { savedEntities[$0] }.forEach(container.viewContext.delete)
       saveData()
   }
    
    func deleteFavorite(character: Digimon) throws {
        //
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        let namePredicate = NSPredicate(format: "name == %@", character.name)
        let levelPredicate = NSPredicate(format: "level == %@", character.level)
        let imgPredicate = NSPredicate(format: "img == %@", character.img)

        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [namePredicate, levelPredicate, imgPredicate])
        request.predicate = compoundPredicate


        do {
            let deleteResult = try container.viewContext.execute(NSBatchDeleteRequest(fetchRequest: request))
            saveData()

        } catch {
            //Handle errors
            print(error)
            print("There was an error deleting favorite")
        }
    }
    
    func isFavorite(character: Digimon) -> Bool {
        savedEntities.contains {
            $0.name == character.name && $0.img == character.img && $0.level == character.level
        }
    }

    
}
