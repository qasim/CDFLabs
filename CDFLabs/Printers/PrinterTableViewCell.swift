//
//  PrinterTableViewCell.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 1/2/16.
//  Copyright © 2016 Qasim Iqbal. All rights reserved.
//

import UIKit


class PrinterTableViewCell: UITableViewCell {

    var insetView: UIView?
    var highlightedColor = UIColor(red: 222 / 255, green: 222 / 255, blue: 222 / 255, alpha: 1.0)

    var freeViewSize: CGFloat = 0

    init(printer: Printer) {
        super.init(style: .Default, reuseIdentifier: printer.name)
        
        self.backgroundColor = UIColor.cdfGreyColor()
        
        let insetView = self.createInsetView(printer)
        self.addSubview(insetView)
        
        let viewsDict: [String: AnyObject] = [
            "insetView": insetView
        ]
        
        let metricsDict: [String: AnyObject] = [
            "cellPadding": CLTable.cellPadding,
            "cellHeight": CLTable.printerCellHeight + 6
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
        var count: Int = 0
        var sizeString: String = ""
        if printer.jobs.count > 0 {
            var size: Int = 0
            for printJob in printer.jobs {
                if !printJob.rank.containsString("done") {
                    count += 1
                    size += Int(ceil(printJob.size))
                }
            }

            let f = NSNumberFormatter()
            f.numberStyle = .DecimalStyle
            sizeString = f.stringFromNumber(size)!
        }

        let insetView = UIView()
        insetView.translatesAutoresizingMaskIntoConstraints = false
        insetView.backgroundColor = UIColor.whiteColor()
        insetView.layer.cornerRadius = CLTable.cellCornerRadius
        self.insetView = insetView

        let freeView = self.createFreeView(printer, count: count)
        insetView.addSubview(freeView)

        let printerNameLabel = UILabel()
        printerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        printerNameLabel.textColor = UIColor.blackColor()
        printerNameLabel.font = UIFont.systemFontOfSize(24.0, weight: UIFontWeightLight)
        printerNameLabel.text = printer.name
        insetView.addSubview(printerNameLabel)

        let printerDescLabel = UILabel()
        printerDescLabel.translatesAutoresizingMaskIntoConstraints = false
        printerDescLabel.textColor = UIColor.darkGrayColor()
        printerDescLabel.font = UIFont.systemFontOfSize(18.0, weight: UIFontWeightLight)
        printerDescLabel.lineBreakMode = .ByWordWrapping
        printerDescLabel.numberOfLines = 0
        printerDescLabel.text = printer.description
        insetView.addSubview(printerDescLabel)

        let printerDetailsLabel = UILabel()
        printerDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        printerDetailsLabel.textColor = UIColor.grayColor()
        printerDetailsLabel.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightLight)

        var s = "s"
        if count == 1 {
            s = ""
        }
        if count > 0 {
            printerDetailsLabel.text = "\(count) job\(s) queued (\(sizeString) KB)"
        } else {
            printerDetailsLabel.text = "No jobs queued"
        }
        
        insetView.addSubview(printerDetailsLabel)
        
        let viewsDict: [String: AnyObject] = [
            "insetView": insetView,
            "freeView": freeView,
            "printerNameLabel": printerNameLabel,
            "printerDetailsLabel": printerDetailsLabel,
            "printerDescLabel": printerDescLabel
        ]
        
        let metricsDict: [String: AnyObject] = [
            "cellPadding": CLTable.cellPadding,
            "cellHeight": CLTable.printerCellHeight,
            "freeViewSize": self.freeViewSize
        ]
        
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[printerNameLabel]", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[printerDescLabel]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[freeView(freeViewSize)]-[printerDetailsLabel]", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[freeView(20)]", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-16-[printerNameLabel][printerDescLabel]-12-[printerDetailsLabel]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[printerDescLabel]-12-[freeView]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        return insetView
    }
    
    func createFreeView(printer: Printer, count: Int) -> UIView {
        let freeView = UIView()
        freeView.translatesAutoresizingMaskIntoConstraints = false
        freeView.layer.cornerRadius = CLTable.cellCornerRadius
        
        let freeTextLabel = UILabel()
        freeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        freeTextLabel.textColor = UIColor.whiteColor()
        freeTextLabel.textAlignment = .Center
        freeTextLabel.font = UIFont.systemFontOfSize(14.0)
        
        freeView.addSubview(freeTextLabel)
        
        if count > 0 {
            freeView.backgroundColor = UIColor.cdfYellowColor()
            freeTextLabel.text = "BUSY"
        } else {
            freeView.backgroundColor = UIColor.cdfGreenColor()
            freeTextLabel.text = "FREE"
        }

        self.freeViewSize = freeTextLabel.text!.calculatedWidth(freeTextLabel.font) +
            (2 * CLTable.tagPadding)
        
        let viewsDict: [String: AnyObject] = [
            "freeTextLabel": freeTextLabel
        ]
        
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        freeView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|[freeTextLabel]|", options: options, metrics: nil, views: viewsDict))
        
        freeView.addConstraint(NSLayoutConstraint(item: freeTextLabel, attribute: .CenterY, relatedBy: .Equal, toItem: freeView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        return freeView
    }

    override func setSelected(selected: Bool, animated: Bool) {
        // Do nothing
    }

    override func setHighlighted(highlighted: Bool, animated: Bool) {
        if (highlighted) {
            self.insetView!.backgroundColor = self.highlightedColor
        } else {
            self.insetView!.backgroundColor = UIColor.whiteColor()
        }
    }
}