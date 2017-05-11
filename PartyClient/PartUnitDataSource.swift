//
//  PartUnitDataSource.swift
//  PartyClient
//
//  Created by Justin on 2017-05-11.
//  Copyright © 2017 Justin. All rights reserved.

import UIKit

class PartUnitDataSource: NSObject {
    let units: [String]
    
    init(units: [String]){
        self.units = units
    }
    
}

extension PartUnitDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return units.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PartUnitCell.self)) as! PartUnitCell
        let unit = units[indexPath.row]
        cell.newName = unit
        return cell
    }
}
