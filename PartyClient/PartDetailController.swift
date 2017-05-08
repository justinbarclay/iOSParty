//
//  PartDetailController.swift
//  PartyClient
//
//  Created by Justin on 2017-05-06.
//  Copyright © 2017 Justin. All rights reserved.
//

import UIKit

struct PartHistory{
    let user: String
    let date: Date
    let netChange: Int32
}

struct Part{
    let name: String
    let room: String
    let shelf: String
    let count: Int
    let history: [PartHistory]
    
}

class PartDetailController: UIViewController {
    var productID: String?
    let dataSource: PartHistoryDataSource
    let part: Part
    
    
    @IBOutlet weak var partHistoryTable: UITableView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var shelf: UILabel!
    @IBOutlet weak var count: UITextField!
    
    @IBOutlet weak var room: UILabel!
    required init?(coder aDecoder: NSCoder){
        let history = [
            PartHistory(user: "Justin", date: Date.init(), netChange: -10),
            PartHistory(user: "Justin", date: Date.init(), netChange: 20),
            PartHistory(user: "Justin", date: Date.init(), netChange: -5)
        ]
        part = Part(name: "Gasket", room: "Mechanical Storage Room", shelf: "A3", count: 20, history: history)
        
        self.dataSource = PartHistoryDataSource(partsHistory: part.history)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load up the historyTable
        partHistoryTable.dataSource = dataSource
        partHistoryTable.reloadData()

        // Set up
        productName.text = part.name
        shelf.text = part.shelf
        room.text = part.room
        count.text = String(part.count)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
