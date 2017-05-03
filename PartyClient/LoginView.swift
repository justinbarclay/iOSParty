//
//  ViewController.swift
//  PartyClient
//
//  Created by Justin on 2017-05-01.
//  Copyright © 2017 Justin. All rights reserved.
//

import UIKit
import Foundation
import Security

class LoginController: UIViewController {

    @IBOutlet weak var _email: UITextField!
    
    
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var _loginButton: UIButton!
    
    let _testServer = "http://localhost:61222"
//    let _server = "http://partyserver.dev/user_token"
    let _server = "http://localhost:3000/user_token"
    
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
//        let url = URL(string: _testServer)
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
        loginInfo["email"] = username
        loginInfo["password"] = password
        container["auth"] = loginInfo
        
        // Generic setup for making a URL request
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
    
        
        do{
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: container, options: [])
        } catch {
            print("JSON Error")
            return
        }
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            print(String(data: data!, encoding: String.Encoding.utf8))
            print(response)
            print(error)
        }
        task.resume()
    }
    
//    private class func save(service: NSString, data: NSString) {
//        let dataFromString: NSData = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
//        
//        // Instantiate a new default keychain query
//        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
//        
//        // Delete any existing items
//        SecItemDelete(keychainQuery as CFDictionaryRef)
//        
//        // Add the new keychain item
//        SecItemAdd(keychainQuery as CFDictionaryRef, nil)
//    }
}
