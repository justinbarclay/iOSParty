//
//  PartHistoryDataSource.swift
//  PartyClient
//
//  Created by Justin on 2017-05-06.
//  Copyright © 2017 Justin. All rights reserved.
//

import UIKit

class PartHistoryDataSource: NSObject {
    let partsHistory: [PartHistory]
    
    init(partsHistory: [PartHistory]){
        self.partsHistory = partsHistory
    }
    
}

extension PartHistoryDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partsHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PartHistoryCell())) as! PartHistoryCell
        let partHistory = partsHistory[indexPath.row]
        cell.user = partHistory.user
        cell.info = partHistory.date.description + "\t\t" + partHistory.netChange.description
        return cell
    }
}
