//
//  PartDetailController.swift
//  PartyClient
//
//  Created by Justin on 2017-05-06.
//  Copyright © 2017 Justin. All rights reserved.
//

import UIKit
import CoreGraphics

class PartDetailController: UIViewController {
    var productID: String?
    var historyDataSource: PartHistoryDataSource
    var unitDataSource: PartUnitDataSource
    var part: Part?
    var partsHistory: [PartHistory]
    var partsUnits: [String]
    
    
    @IBOutlet weak var partHistoryTable: UITableView!
    @IBOutlet weak var unitTable: UITableView!
    
    @IBOutlet weak var shelf: UILabel!
    @IBOutlet weak var count: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var unitTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    

    @IBOutlet weak var room: UILabel!
    @IBOutlet weak var Stepper: UIStepper!

    required init?(coder aDecoder: NSCoder){
        partsHistory = []
        partsUnits = []
        self.historyDataSource = PartHistoryDataSource(partsHistory: partsHistory)
        self.unitDataSource = PartUnitDataSource(units: partsUnits)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PartDataStore.getPart(id: productID,callback: setPart)
        
        navBar.backItem?.title = "Back"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.historyDataSource = PartHistoryDataSource(partsHistory: part!.history)
        self.unitDataSource = PartUnitDataSource(units: part!.units)
        
        // Load up the historyTable
        partHistoryTable.dataSource = historyDataSource
        partHistoryTable.reloadData()
        
        unitTable.dataSource = unitDataSource
        unitTable.reloadData()
        unitTableHeightConstraint.constant = CGFloat(part!.units.count) * 44
        self.view.layoutIfNeeded()
        Stepper.maximumValue = 1000000000
        // Set up
        Stepper.value = Double(part!.count)
        shelf.text = part!.shelf
        room.text = part!.room
        count.text = String(part!.count)
        
        navBar.topItem?.title = part!.name
    }
    
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        count.text = String(Int(sender.value))
    }
    @IBAction func back(_ sender: UIBarButtonItem) {
        //performSegue(withIdentifier: "backToScanner", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setPart(part: Part?) -> Void {
        if let parts = part {
            self.part = parts
        }else{
            self.dismiss(animated: false, completion: nil)
            return
        }
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
