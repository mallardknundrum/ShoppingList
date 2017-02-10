//
//  ShoppingListButtonTableViewCell.swift
//  ShoppingList
//
//  Created by Jeremiah Hawks on 2/10/17.
//  Copyright © 2017 Jeremiah Hawks. All rights reserved.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    weak var delegate: ItemButtonTableViewCellDelegate?
    
    var item: Item? {
        didSet {
            updateViews()
        }
    }
   
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        delegate?.isCompleteButtonTapped(sender: self)
    }
    
    func updateViews() {
        guard let item = item else { return itemName.text = "" }
        itemName.text = item.name
        if item.isComplete {
            isCompleteButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            isCompleteButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }

}

protocol ItemButtonTableViewCellDelegate: class {
    func isCompleteButtonTapped(sender: ShoppingListTableViewCell)
}
