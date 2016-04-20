//
//  PrintJob.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 1/3/16.
//  Copyright © 2016 Qasim Iqbal. All rights reserved.
//

import Foundation

public class PrintJob {

    var id: String
    var owner: String
    var rank: String
    var size: Double // in KB
    var time: String // HH:MM:SS
    
    public init() {
        self.id = "0"
        self.owner = "N/A"
        self.rank = "done"
        self.size = 0.0
        self.time = "00:00:00"
    }
    
    public init(owner: String, rank: String, size: String, time: String) {
        self.id = owner
        self.owner = owner.characters.split("@").map(String.init)[0]
        self.rank = rank
        if size == "" {
            self.size = 0.0
        } else {
            self.size = Double(size)! / 1024
        }
        self.time = time
    }
}
