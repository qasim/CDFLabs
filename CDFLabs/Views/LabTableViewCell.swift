//
//  LabTableViewCell.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/31/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit

class LabTableViewCell: UITableViewCell {
    
    var insetView: UIView?
    
    init(lab: Lab?) {
        super.init(style: .Default, reuseIdentifier: lab?.lab)

        self.backgroundColor = UIColor.cdfGreyColor()
        
        self.insetView = UIView()
        self.insetView?.translatesAutoresizingMaskIntoConstraints = false
        self.insetView?.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.insetView!)
        
        let viewsDict: [String: AnyObject] = [
            "insetView": self.insetView!
        ]
        
        let metricsDict: [String: AnyObject] = [
            "cellPadding": LabTable.cellPadding,
            "cellHeight": LabTable.cellHeight
        ]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-cellPadding-[insetView]-cellPadding-|", options: .AlignAllLeft, metrics: metricsDict, views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[insetView(cellHeight)]-cellPadding-|", options: .AlignAllTop, metrics: metricsDict, views: viewsDict))

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
