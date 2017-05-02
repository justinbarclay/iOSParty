//
//  ViewController.swift
//  PartyClient
//
//  Created by Justin on 2017-05-01.
//  Copyright © 2017 Justin. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var _email: UITextField!
    
    
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var _loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginUser(_ sender: UIButton) {
    }
}

