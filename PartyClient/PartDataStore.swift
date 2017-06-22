//
//  PartDataStore.swift
//  PartyClient
//
//  Created by Justin on 2017-05-10.
//  Copyright © 2017 Justin. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

struct PartHistory{
    let user: String
    let date: Date
    let netChange: Int32
    
    init(json: [String: Any?]) throws{
        guard let user = json["user"] as? String else {
            throw SerializationError.missing("user")
        }
        
        guard let date = json["data"] as? String else {
            throw SerializationError.missing("date")
        }
        
        guard let netChange = json["netChange"] as? Int32 else {
            throw SerializationError.missing("netChange")
        }
        
        self.user = user
        self.date = Date()
        self.netChange = netChange
    }
}

struct Part{
    let name: String
    let room: String
    let units: [String]
    let shelf: String
    var count: Int
    let history: [PartHistory]
    
//    func toHash() -> [String: Any]{
//        // for easy jsonilization
//    }
    
    init(json: [String: Any?]) throws {
        guard let name = json["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        guard let unitsJSON = json["units"] as? [[String:String]] else {
            throw SerializationError.missing("units")
        }
        
        guard let room = json["room"] as? String else {
            throw SerializationError.missing("room")
        }
       guard  let shelf = json["shelf"] as? String else {
            throw SerializationError.missing("shelf")
        }
        guard let count = json["count"] as? Int else {
            throw SerializationError.missing("count")
        }

//      PartHistory stuff is not ready for primetime
//        guard let partHistory = json["part_histories"] as? [[String:Any?]] else {
//            throw SerializationError.missing("PartHistory")
//        }
        
        var units: [String] = []
        for unitObject in unitsJSON {
            units.append(unitObject["name"]!)
        }
        
       var history: [PartHistory] = []
//        
//        for item in partHistory{
//            do {
//                let element = try PartHistory(json: item)
//                history.append(element)
//            } catch {
//                break
//            }
//            
//        }
        self.name = name
        self.count = count
        self.units = units
        self.room = room
        self.shelf = shelf
        self.history = history
    }
}

class PartDataStore {
    private static let _testServer: String = "http://partyserver.192.168.0.11.xip.io/api/parts/"
    private var parts: [String: Part] = [:]
    
//    static func getPart(id: String?) {
//        print(id!)
//        if (id == nil){
//            return nil
//        }
//        let history = [
//            PartHistory(user: "Justin", date: Date.init(), netChange: -10),
//            PartHistory(user: "Justin", date: Date.init(), netChange: 20),
//            PartHistory(user: "Justin", date: Date.init(), netChange: -5)
//        ]
//        let units = ["Unit 1", "Unit 2", "Unit 3", "Unit 4", "Unit 5", "Unit 6"]
//        let part = Part(name: "Gasket", room: "Mechanical Storage Room", units: units, shelf: "A3", count: 20, history: history)
//        return part
//    }
    
    static func savePart(part: Part) -> Bool{
        return false
    }
    
    private static func getToken() -> String?{
        do {
            let loggedIn = try KeychainTokenItem.tokenItems(forService: KeychainConfiguration.serviceName)
            do {
                let token = try loggedIn[0].readToken()
                return token
            } catch{
                return nil
            }
        } catch {
            // Do we care about specific errors?
            return nil
        }
    }
    
    // This is the laziest quicket way I know of to deal with asynchronous events (because this is talking to a server)
    // we use the callback pattern for the calling function to pass in a function that allows us to possible pass in resolved data
    // call back should take in a part and then update view accordinglys
    static func getPart(id: String?, callback: @escaping (_ part: Part?) -> Void) {
        let route: String = self._testServer + id!
        let url = URL(string: route)
        // Ensure information has been entered before progressing
        
        
        // Generic setup for making a URL request
        var urlRequest = URLRequest(url: url!)
        
        if let token = self.getToken() {
            urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        } else {
            callback(nil)
        }
        
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard (data != nil) else {
                return
            }
            var jsonData: Any?
            do {
                jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
            } catch {
                return
            }
            
            if let jsonResponse = jsonData as? [String: Any] {
                do {
                    guard let jsonPart = jsonResponse["part"] as? [String: Any?] else{
                        throw SerializationError.missing("part")
                    }
                    let part = try Part(json: jsonPart)
                    callback(part)
                    return
                } catch {
                    
                    // Maybe do something here later
                }
            }
            // General handle all callback, if we don't hit the one positive case in this closure return nil into callback
            callback(nil)
        }
        task.resume()
    }
}
