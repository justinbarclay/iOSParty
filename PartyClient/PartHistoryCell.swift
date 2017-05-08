//
//  PartHistoryCell.swift
//  PartyClient
//
//  Created by Justin on 2017-05-05.
//  Copyright © 2017 Justin. All rights reserved.
//

import UIKit

class PartHistoryCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var user: String? {
        didSet {
            userName.text = user
        }
    }
    
    var info: String? {
        didSet {
            history.text = info
        }
    }
}
