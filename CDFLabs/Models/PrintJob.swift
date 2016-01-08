//
//  PrintJob.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 1/3/16.
//  Copyright © 2016 Qasim Iqbal. All rights reserved.
//

import Foundation

public class PrintJob {
    
    var rank: String
    var size: Double // in KB
    
    public init() {
        self.rank = "done"
        self.size = 0.0
    }
    
    public init(rank: String, size: String) {
        self.rank = rank
        if size == "" {
            self.size = 0.0
        } else {
            self.size = Double(size)! / 1024
        }
    }
}
