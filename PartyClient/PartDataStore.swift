//
//  PartDataStore.swift
//  PartyClient
//
//  Created by Justin on 2017-05-10.
//  Copyright © 2017 Justin. All rights reserved.
//

import Foundation

struct PartHistory{
    let user: String
    let date: Date
    let netChange: Int32
}

struct Part{
    let name: String
    let room: String
    let units: [String]
    let shelf: String
    var count: Int
    let history: [PartHistory]
    
}

struct PartDataStore {
    private var parts: [String: Part]
    
    static func getPart(id: String?) -> Part? {
        print(id!)
        if (id == nil){
            return nil
        }
        let history = [
            PartHistory(user: "Justin", date: Date.init(), netChange: -10),
            PartHistory(user: "Justin", date: Date.init(), netChange: 20),
            PartHistory(user: "Justin", date: Date.init(), netChange: -5)
        ]
        let part = Part(name: "Gasket", room: "Mechanical Storage Room", units: [], shelf: "A3", count: 20, history: history)
        return part
    }
    
    static func savePart(part: Part) -> Bool{
        return false
    }
}
