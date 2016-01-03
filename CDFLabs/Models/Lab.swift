//
//  Lab.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/30/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import Foundation

public class Lab {
    
    var name: String
    var timestamp: String
 
    var avail: Int
    var busy: Int
    var total: Int
    
    var percent: Int
    
    public init() {
        self.name = ""
        self.avail = 0
        self.busy = 0
        self.total = 0
        self.percent = 0
        self.timestamp = ""
    }
    
    public init(name: String, avail: Int, busy: Int, total: Int, timestamp: String) {
        self.name = name
        self.avail = avail
        self.busy = busy
        self.total = total
        self.percent = Int(Double(round(100 * (Double(busy) / Double(total))) / 100) * 100)
        self.timestamp = timestamp
    }
}
