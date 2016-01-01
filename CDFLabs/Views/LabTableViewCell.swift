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
        super.init(style: .Default, reuseIdentifier: lab.lab)

        self.backgroundColor = UIColor.cdfGreyColor()
        
        let insetView = UIView()
        insetView.translatesAutoresizingMaskIntoConstraints = false
        insetView.backgroundColor = UIColor.whiteColor()
        insetView.layer.cornerRadius = LabTable.cellCornerRadius
        self.addSubview(insetView)
        
        let freeView = UIView()
        freeView.translatesAutoresizingMaskIntoConstraints = false
        freeView.backgroundColor = UIColor.cdfGreenColor()
        freeView.layer.cornerRadius = LabTable.cellCornerRadius
        
        let freeTextLabel = UILabel()
        freeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        freeTextLabel.textColor = UIColor.whiteColor()
        freeTextLabel.textAlignment = .Center
        freeTextLabel.font = UIFont.systemFontOfSize(14.0)
        freeTextLabel.text = "FREE"
        freeView.addSubview(freeTextLabel)
        
        let freeValueLabel = UILabel()
        freeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        freeValueLabel.textColor = UIColor.whiteColor()
        freeValueLabel.textAlignment = .Center
        freeValueLabel.font = UIFont.systemFontOfSize(32.0)
        freeValueLabel.text = String(lab.avail)
        freeView.addSubview(freeValueLabel)
        
        let labNameLabel = UILabel()
        labNameLabel.translatesAutoresizingMaskIntoConstraints = false
        labNameLabel.textColor = UIColor.blackColor()
        labNameLabel.font = UIFont.systemFontOfSize(24.0, weight: UIFontWeightLight)
        labNameLabel.text = lab.lab
        insetView.addSubview(labNameLabel)
        
        let labDetailsLabel = UILabel()
        labDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        labDetailsLabel.textColor = UIColor.grayColor()
        labDetailsLabel.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightLight)
        labDetailsLabel.text = "\(lab.total) computers total (\(lab.percent)% busy)"
        insetView.addSubview(labDetailsLabel)
        
        insetView.addSubview(freeView)
        
        let viewsDict: [String: AnyObject] = [
            "insetView": insetView,
            "freeView": freeView,
            "freeTextLabel": freeTextLabel,
            "freeValueLabel": freeValueLabel,
            "labNameLabel": labNameLabel,
            "labDetailsLabel": labDetailsLabel
        ]
        
        let metricsDict: [String: AnyObject] = [
            "cellPadding": LabTable.cellPadding,
            "cellHeight": LabTable.cellHeight,
            "freeViewHeight": LabTable.cellHeight - (2 * LabTable.cellPadding),
            "freeViewPadding": 8.0,
        ]
        
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-cellPadding-[insetView]-cellPadding-|", options: options, metrics: metricsDict, views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[insetView(cellHeight)]-cellPadding-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-cellPadding-[freeView(freeViewHeight)]-16-[labNameLabel]", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-cellPadding-[freeView(freeViewHeight)]-cellPadding-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "[freeView]-16-[labDetailsLabel]", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-16-[labNameLabel]-cellPadding-[labDetailsLabel]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        freeView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|[freeTextLabel]|", options: options, metrics: metricsDict, views: viewsDict))
        
        freeView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|[freeValueLabel]|", options: options, metrics: metricsDict, views: viewsDict))
        
        freeView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-freeViewPadding-[freeValueLabel][freeTextLabel]-freeViewPadding-|", options: options, metrics: metricsDict, views: viewsDict))
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
