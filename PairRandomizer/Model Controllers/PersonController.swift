//
//  PersonController.swift
//  PairRandomizer
//
//  Created by Jaime Almanza on 23/02/18.
//  Copyright © 2018 Jaime Almanza. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    // MARK: - Properties
    
    static let shared = PersonController()
    var persons = [Person]()
    
    
    // MARK: - Initializer
    
    init() {
        persons = loadFromPersistentStore()
    }
    
    
    // MARK: - CRUD
    
    func add(personWithName name: String) {
        Person(name: name)
        saveToPersistentStore()
        persons = loadFromPersistentStore()
    }
    
    func update(person: Person, withName name: String) {
        person.name = name
        saveToPersistentStore()
        persons = loadFromPersistentStore()
    }
    
    func delete(person: Person) {
        if let moc = person.managedObjectContext {
            moc.delete(person)
            saveToPersistentStore()
            persons = loadFromPersistentStore()
        }
    }
    
    
    // MARK: - Saving and Loading
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving to persistent store: \(error) \(error.localizedDescription) \(#file) \(#function)")
        }
    }
    
    func loadFromPersistentStore() -> [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            let array = (try CoreDataStack.context.fetch(request))
            return array
        } catch {
            print("Error loading from persistent store: \(error) \(error.localizedDescription) \(#file) \(#function)")
            return []
        }
    }
    
}
