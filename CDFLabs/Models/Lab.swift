//
//  Lab.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/30/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import Foundation

public class Lab {
    
    var lab: String?
    var timestamp: String?
 
    var avail: Int?
    var busy: Int?
    var total: Int?
    
    var percent: Double?
    
    public init() {
        self.lab = nil
        self.avail = 0
        self.busy = 0
        self.total = 0
        self.percent = 0
        self.timestamp = nil
    }
}
