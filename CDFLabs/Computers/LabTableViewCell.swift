//
//  LabTableViewCell.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/31/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit

class LabTableViewCell: UITableViewCell {
    
    init(lab: Lab) {
        super.init(style: .Default, reuseIdentifier: lab.name)

        self.backgroundColor = UIColor.cdfGreyColor()
        
        let insetView = self.createInsetView(lab)
        self.addSubview(insetView)
        
        let viewsDict: [String: AnyObject] = [
            "insetView": insetView
        ]
        
        let metricsDict: [String: AnyObject] = [
            "cellPadding": CLTable.cellPadding,
            "cellHeight": CLTable.cellHeight
        ]
        
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-cellPadding-[insetView]-cellPadding-|", options: options, metrics: metricsDict, views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[insetView(cellHeight)]-cellPadding-|", options: options, metrics: metricsDict, views: viewsDict))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createInsetView(lab: Lab) -> UIView {
        let insetView = UIView()
        insetView.translatesAutoresizingMaskIntoConstraints = false
        insetView.backgroundColor = UIColor.whiteColor()
        insetView.layer.cornerRadius = CLTable.cellCornerRadius
        
        let freeView = self.createFreeView(lab)
        insetView.addSubview(freeView)
        
        let labNameLabel = UILabel()
        labNameLabel.translatesAutoresizingMaskIntoConstraints = false
        labNameLabel.textColor = UIColor.blackColor()
        labNameLabel.font = UIFont.systemFontOfSize(24.0, weight: UIFontWeightLight)
        labNameLabel.text = lab.name
        insetView.addSubview(labNameLabel)
        
        let labDetailsLabel = UILabel()
        labDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        labDetailsLabel.textColor = UIColor.grayColor()
        labDetailsLabel.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightLight)
        labDetailsLabel.text = "\(lab.total) computers total (\(lab.percent)% busy)"
        insetView.addSubview(labDetailsLabel)
        
        let viewsDict: [String: AnyObject] = [
            "insetView": insetView,
            "freeView": freeView,
            "labNameLabel": labNameLabel,
            "labDetailsLabel": labDetailsLabel
        ]
        
        let metricsDict: [String: AnyObject] = [
            "cellPadding": CLTable.cellPadding,
            "cellHeight": CLTable.cellHeight,
            "freeViewHeight": CLTable.cellHeight - (2 * CLTable.cellPadding)
        ]
        
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-cellPadding-[freeView(freeViewHeight)]-16-[labNameLabel]", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-cellPadding-[freeView(freeViewHeight)]-cellPadding-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "[freeView]-16-[labDetailsLabel]", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-16-[labNameLabel]-cellPadding-[labDetailsLabel]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        return insetView
    }
    
    func createFreeView(lab: Lab) -> UIView {
        let freeView = UIView()
        freeView.translatesAutoresizingMaskIntoConstraints = false
        
        if lab.percent == 100 {
            freeView.backgroundColor = UIColor.cdfRedColor()
        } else if lab.percent >= 80 {
            freeView.backgroundColor = UIColor.cdfYellowColor()
        } else {
            freeView.backgroundColor = UIColor.cdfGreenColor()
        }
        
        freeView.layer.cornerRadius = CLTable.cellCornerRadius
        
        let freeTextLabel = UILabel()
        freeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        freeTextLabel.textColor = UIColor.whiteColor()
        freeTextLabel.textAlignment = .Center
        freeTextLabel.font = UIFont.systemFontOfSize(12.0)
        freeTextLabel.text = "FREE"
        freeView.addSubview(freeTextLabel)
        
        let freeValueLabel = UILabel()
        freeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        freeValueLabel.textColor = UIColor.whiteColor()
        freeValueLabel.textAlignment = .Center
        freeValueLabel.font = UIFont.systemFontOfSize(32.0)
        freeValueLabel.text = String(lab.avail)
        freeView.addSubview(freeValueLabel)
        
        let viewsDict: [String: AnyObject] = [
            "freeTextLabel": freeTextLabel,
            "freeValueLabel": freeValueLabel
        ]
        
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        freeView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|[freeTextLabel]|", options: options, metrics: nil, views: viewsDict))
        
        freeView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|[freeValueLabel]|", options: options, metrics: nil, views: viewsDict))
        
        freeView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-6-[freeValueLabel][freeTextLabel]-10-|", options: options, metrics: nil, views: viewsDict))
        
        return freeView
    }
}
