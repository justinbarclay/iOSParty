//
//  PartUnitCell.swift
//  PartyClient
//
//  Created by Justin on 2017-05-11.
//  Copyright © 2017 Justin. All rights reserved.
//
import UIKit

class PartUnitCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    var newName: String? {
        didSet {
            self.name.text = newName
        }
    }
}
