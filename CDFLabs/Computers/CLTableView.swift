//
//  LabTableView.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/31/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit

class CLTableView: UITableView {
    
    init() {
        super.init(frame: UIScreen.mainScreen().bounds, style: .Plain)
        
        let backgroundView = UIView(frame: self.frame)
        backgroundView.backgroundColor = UIColor.cdfGreyColor()
        self.backgroundView = backgroundView
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorStyle = .None
        // self.allowsSelection = false
        self.contentInset = UIEdgeInsetsMake(CLTable.cellPadding, 0, 0, 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
