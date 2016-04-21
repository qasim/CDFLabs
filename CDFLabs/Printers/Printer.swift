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
        if self.description.containsString(" redirected ") {
            self.description = self.description.componentsSeparatedByString(" redirected ")[1]
            self.description = self.description.componentsSeparatedByString("(")[0]
            self.description = "Redirected \(self.description)"
        }

        self.jobs = jobs
        // Pin jobs marked as "done" to the top
        if self.jobs.count > 0 {
            for i in 0...(self.jobs.count - 1) {
                if self.jobs[i].rank.containsString("done") {
                    self.jobs.insert(self.jobs.removeAtIndex(i), atIndex: 0)
                }
            }
        }
    }
}
