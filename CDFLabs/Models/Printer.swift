//
//  Printer.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 1/2/16.
//  Copyright © 2016 Qasim Iqbal. All rights reserved.
//

import Foundation

public class Printer {
    
    var name: String
    var description: String
    var jobs: [PrintJob]
    
    public init() {
        self.name = ""
        self.description = ""
        self.jobs = []
    }
    
    public init(name: String, description: String, jobs: [PrintJob]) {
        self.name = name
        self.description = description
        self.jobs = jobs
    }
}
