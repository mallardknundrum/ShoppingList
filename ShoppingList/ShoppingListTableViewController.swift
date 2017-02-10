//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Jeremiah Hawks on 2/10/17.
//  Copyright © 2017 Jeremiah Hawks. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController, ItemButtonTableViewCellDelegate {
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add a shopping list item", message: "Please enter an item to add to your list", preferredStyle: .alert)
        var itemNameTextField: UITextField?
        alertController.addTextField { (textField) in
            itemNameTextField = textField
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let itemName = itemNameTextField?.text else { return }
            ItemController.shared.createItem(withName: itemName)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hold on to your butts...")
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.shared.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingListCell", for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        let item = ItemController.shared.items[indexPath.row]
        cell.item = item
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = ItemController.shared.items[indexPath.row]
            ItemController.shared.deleteItem(item: item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func isCompleteButtonTapped(sender: ShoppingListTableViewCell) {
        guard let item = sender.item, let indexPath = tableView.indexPath(for: sender) else { return }
        ItemController.shared.toggleIsCompleteButton(for: item)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
