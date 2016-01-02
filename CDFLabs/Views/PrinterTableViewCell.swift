//
//  PrinterTableViewCell.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 1/2/16.
//  Copyright © 2016 Qasim Iqbal. All rights reserved.
//

import UIKit


class PrinterTableViewCell: UITableViewCell {
    
    init(printer: Printer) {
        super.init(style: .Default, reuseIdentifier: "")
        
        self.backgroundColor = UIColor.cdfGreyColor()
        
        let insetView = self.createInsetView(printer)
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
    
    func createInsetView(printer: Printer) -> UIView {
        let insetView = UIView()
        insetView.translatesAutoresizingMaskIntoConstraints = false
        insetView.backgroundColor = UIColor.whiteColor()
        insetView.layer.cornerRadius = CLTable.cellCornerRadius
        
        let freeView = self.createFreeView(printer)
        insetView.addSubview(freeView)
        
        let printerNameLabel = UILabel()
        printerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        printerNameLabel.textColor = UIColor.blackColor()
        printerNameLabel.font = UIFont.systemFontOfSize(24.0, weight: UIFontWeightLight)
        printerNameLabel.text = "Printer name"
        insetView.addSubview(printerNameLabel)
        
        let printerDetailsLabel = UILabel()
        printerDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        printerDetailsLabel.textColor = UIColor.grayColor()
        printerDetailsLabel.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightLight)
        printerDetailsLabel.text = "2 jobs queued (34 pages left)"
        insetView.addSubview(printerDetailsLabel)
        
        let viewsDict: [String: AnyObject] = [
            "insetView": insetView,
            "freeView": freeView,
            "printerNameLabel": printerNameLabel,
            "printerDetailsLabel": printerDetailsLabel
        ]
        
        let metricsDict: [String: AnyObject] = [
            "cellPadding": CLTable.cellPadding,
            "cellHeight": CLTable.cellHeight,
            "freeViewHeight": CLTable.cellHeight - (2 * CLTable.cellPadding)
        ]
        
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-cellPadding-[freeView(freeViewHeight)]-16-[printerNameLabel]", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-cellPadding-[freeView(freeViewHeight)]-cellPadding-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "[freeView]-16-[printerDetailsLabel]", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-16-[printerNameLabel]-cellPadding-[printerDetailsLabel]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        return insetView
    }
    
    func createFreeView(printer: Printer) -> UIView {
        let freeView = UIView()
        freeView.translatesAutoresizingMaskIntoConstraints = false
        freeView.backgroundColor = UIColor.cdfGreenColor()
        freeView.layer.cornerRadius = CLTable.cellCornerRadius
        
        let freeTextLabel = UILabel()
        freeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        freeTextLabel.textColor = UIColor.whiteColor()
        freeTextLabel.textAlignment = .Center
        freeTextLabel.font = UIFont.systemFontOfSize(14.0)
        freeTextLabel.text = "FREE"
        freeView.addSubview(freeTextLabel)
        
        let viewsDict: [String: AnyObject] = [
            "freeTextLabel": freeTextLabel
        ]
        
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        freeView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|[freeTextLabel]|", options: options, metrics: nil, views: viewsDict))
        
        freeView.addConstraint(NSLayoutConstraint(item: freeTextLabel, attribute: .CenterY, relatedBy: .Equal, toItem: freeView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        return freeView
    }
}