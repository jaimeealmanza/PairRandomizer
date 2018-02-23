//
//  PairRandomizer+Convenience.swift
//  PairRandomizer
//
//  Created by Jaime Almanza on 23/02/18.
//  Copyright © 2018 Jaime Almanza. All rights reserved.
//

import Foundation
import CoreData

extension Person {
    // @discardableResult is used so we don't have to assign a new instance of our object to a constant that we are not going to use (call) never
    @discardableResult convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        // This is the generic blob of play-doh
        self.init(context: context)
        // Then we sculpt the play-doh into our Object entity to make it unique.
        self.name = name
    }
}
