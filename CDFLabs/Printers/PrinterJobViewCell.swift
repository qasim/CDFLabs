//
//  PrinterJobViewCell.swift
//  CDFLabs
//
//  Created by Qasim on 2016-04-03.
//  Copyright © 2016 Qasim Iqbal. All rights reserved.
//

import UIKit

class PrinterJobViewCell: UITableViewCell {

    var freeViewSize: CGFloat = 0

    init(job: PrintJob) {
        super.init(style: .Default, reuseIdentifier: job.id)

        self.backgroundColor = UIColor.cdfGreyColor()

        let insetView = self.createInsetView(job)
        self.addSubview(insetView)

        let viewsDict: [String: AnyObject] = [
            "insetView": insetView
        ]

        let metricsDict: [String: AnyObject] = [
            "cellPadding": CLTable.cellPadding,
            "cellHeight": CLTable.cellHeight + 6
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

    func createInsetView(job: PrintJob) -> UIView {
        let insetView = UIView()
        insetView.translatesAutoresizingMaskIntoConstraints = false
        insetView.backgroundColor = UIColor.whiteColor()
        insetView.layer.cornerRadius = CLTable.cellCornerRadius

        let freeView = self.createFreeView(job)
        insetView.addSubview(freeView)

        let ownerLabel = UILabel()
        ownerLabel.translatesAutoresizingMaskIntoConstraints = false
        ownerLabel.textColor = UIColor.blackColor()
        ownerLabel.font = UIFont.systemFontOfSize(20.0, weight: UIFontWeightLight)
        ownerLabel.text = job.owner
        ownerLabel.sizeToFit()
        insetView.addSubview(ownerLabel)

        let jobSizeLabel = UILabel()
        jobSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        jobSizeLabel.textColor = UIColor.grayColor()
        jobSizeLabel.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightLight)

        let f = NSNumberFormatter()
        f.numberStyle = .DecimalStyle
        let sizeString = f.stringFromNumber(ceil(job.size))!
        if job.time.characters.count > 0 {
            jobSizeLabel.text = " \(sizeString) KB  (\(job.time))"
        } else {
            jobSizeLabel.text = " \(sizeString) KB"
        }


        insetView.addSubview(jobSizeLabel)

        let viewsDict: [String: AnyObject] = [
            "insetView": insetView,
            "freeView": freeView,
            "ownerLabel": ownerLabel,
            "jobSizeLabel": jobSizeLabel
        ]

        let metricsDict: [String: AnyObject] = [
            "cellPadding": CLTable.cellPadding,
            "cellHeight": CLTable.printerCellHeight,
            "freeViewSize": self.freeViewSize
        ]

        let options = NSLayoutFormatOptions(rawValue: 0)

        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[ownerLabel]", options: options, metrics: metricsDict, views: viewsDict))

        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[freeView(freeViewSize)]-[jobSizeLabel]", options: options, metrics: metricsDict, views: viewsDict))

        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[freeView(20)]", options: options, metrics: metricsDict, views: viewsDict))

        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-16-[ownerLabel]-12-[jobSizeLabel]-16-|", options: options, metrics: metricsDict, views: viewsDict))

        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[ownerLabel]-12-[freeView]-16-|", options: options, metrics: metricsDict, views: viewsDict))

        return insetView
    }

    func createFreeView(job: PrintJob) -> UIView {
        let freeView = UIView()
        freeView.translatesAutoresizingMaskIntoConstraints = false
        freeView.layer.cornerRadius = CLTable.cellCornerRadius

        let freeTextLabel = UILabel()
        freeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        freeTextLabel.textColor = UIColor.whiteColor()
        freeTextLabel.textAlignment = .Center
        freeTextLabel.font = UIFont.systemFontOfSize(14.0)

        freeView.addSubview(freeTextLabel)

        if job.rank.containsString("done") {
            freeView.backgroundColor = UIColor.cdfGreenColor()
            freeTextLabel.text = "DONE"
        } else if job.rank.containsString("active") {
            freeView.backgroundColor = UIColor.cdfGreenColor()
            freeTextLabel.text = "ACTIVE"
        } else if job.rank.containsString("stalled") {
            freeView.backgroundColor = UIColor.cdfRedColor()
            freeTextLabel.text = "STALLED"
        } else if job.rank.containsString("error") {
            freeView.backgroundColor = UIColor.cdfRedColor()
            freeTextLabel.text = "ERROR"
        } else {
            freeView.backgroundColor = UIColor.cdfYellowColor()
            freeTextLabel.text = "RANK \(job.rank)"
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
        // Do nothing
    }
}
