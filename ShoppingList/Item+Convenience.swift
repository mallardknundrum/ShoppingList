//
//  Item+Convenience.swift
//  ShoppingList
//
//  Created by Jeremiah Hawks on 2/10/17.
//  Copyright © 2017 Jeremiah Hawks. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    @discardableResult convenience init(name: String, isComplete: Bool = false, context: NSManagedObjectContext = Stack.context) {
        self.init(context: context)
        self.name = name
        self.isComplete = isComplete
    }
}
