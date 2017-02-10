//
//  ItemController.swift
//  ShoppingList
//
//  Created by Jeremiah Hawks on 2/10/17.
//  Copyright © 2017 Jeremiah Hawks. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
    // MARK: - Singleton
    static let shared = ItemController()
    
    // MARK: - Create
    func createItem(withName name: String) {
        let _ = Item(name: name)
        saveToPersistentStore()
    }
    
    // MARK: - Read
    var items: [Item] {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let moc = Stack.context
        do {
            let items = try moc.fetch(request)
            return items
        } catch {
            return []
        }
    }
    
    // MARK: - Update
    func toggleIsCompleteButton(for item: Item) {
        item.isComplete = !item.isComplete
        saveToPersistentStore()
    }
    
    
    // MARK: - Delete
    func deleteItem(item: Item) {
        let moc = Stack.context
        moc.delete(item)
        saveToPersistentStore()
    }
    
    // MARK: - Persistant Storage
    func saveToPersistentStore() {
        let moc = Stack.context
        do {
            try moc.save()
        } catch {
            print("Unable to save to persistant store: \(error)")
        }
    }
}
