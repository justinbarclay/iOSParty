//
//  ViewController.swift
//  PartyClient
//
//  Created by Justin on 2017-05-01.
//  Copyright © 2017 Justin. All rights reserved.
//

import UIKit
import Foundation

class LoginController: UIViewController {

    @IBOutlet weak var _email: UITextField!
    
    
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var _loginButton: UIButton!
    
    let _server = "http://localhost:61222"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginUser(_ sender: UIButton) {
        let url = URL(string: _server)
        let username = _email.text
        let password = _password.text
        
        
        // Dict for easy JSONilization
        var loginInfo = [String: String]()
        var container = [String: Any]()
        // Ensure information has been entered before progressing
        if(username == "" || password == ""){
            return
        }
        
        // I am lazy and this is a simple easy way to understand how I am building up the JSON string
        loginInfo["username"] = self._email.text
        loginInfo["password"] = self._password.text
        container["auth"] = loginInfo
        
        // Generic setup for making a URL request
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        let session = URLSession.shared
    
        do{
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: container, options: [])
        } catch {
            print("JSON Error")
            return
        }
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            print(data)
            print(response)
            print(error)
        }
        task.resume()
    }
}

