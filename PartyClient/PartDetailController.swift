//
//  PartDetailController.swift
//  PartyClient
//
//  Created by Justin on 2017-05-06.
//  Copyright © 2017 Justin. All rights reserved.
//

import UIKit

class PartDetailController: UIViewController {
    var productID: String?
    let dataSource: PartHistoryDataSource
    var part: Part?
    var partsHistory: [PartHistory]
    
    
    @IBOutlet weak var partHistoryTable: UITableView!
    @IBOutlet weak var shelf: UILabel!
    @IBOutlet weak var count: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    

    @IBOutlet weak var room: UILabel!
    @IBOutlet weak var Stepper: UIStepper!

    required init?(coder aDecoder: NSCoder){
        partsHistory = []
        self.dataSource = PartHistoryDataSource(partsHistory: partsHistory)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        part = PartDataStore.getPart(id: productID)
        if(self.part == nil){
            self.dismiss(animated: false, completion: nil)
            return
        }
        partsHistory = part!.history
        // Load up the historyTable
        partHistoryTable.dataSource = dataSource
        partHistoryTable.reloadData()

        Stepper.maximumValue = 1000000000
        // Set up
        Stepper.value = Double(part!.count)
        shelf.text = part!.shelf
        room.text = part!.room
        count.text = String(part!.count)
        
        navBar.topItem?.title = part!.name
        navBar.backItem?.title = "Back"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        count.text = String(part!.count)
    }
    @IBAction func back(_ sender: UIBarButtonItem) {
        //performSegue(withIdentifier: "backToScanner", sender: self)
        self.dismiss(animated: true, completion: nil)
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
