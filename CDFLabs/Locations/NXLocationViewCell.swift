//
//  NXLocationView.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 1/5/16.
//  Copyright © 2016 Qasim Iqbal. All rights reserved.
//

import UIKit

class NXLocationViewCell: UITableViewCell {
    
    init() {
        super.init(style: .Default, reuseIdentifier: "NX")
        
        self.backgroundColor = UIColor.cdfGreyColor()
        
        let insetView = self.createInsetView()
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
            "V:|[insetView]-cellPadding-|", options: options, metrics: metricsDict, views: viewsDict))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createInsetView() -> UIView {
        let insetView = UIView()
        insetView.translatesAutoresizingMaskIntoConstraints = false
        insetView.backgroundColor = UIColor.whiteColor()
        insetView.layer.cornerRadius = CLTable.cellCornerRadius

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.systemFontOfSize(24.0, weight: UIFontWeightLight)
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.text = "NX (Remote Access Server)"
        insetView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = UIColor.blackColor()
        descriptionLabel.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightLight)
        descriptionLabel.lineBreakMode = .ByWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "CDF offers an NX server for remote desktop connection from home or from your laptop via the wireless network. The NX technology attempts to greatly improve the experience of remote graphical connection over a slow Internet link by optimising perceived speed of response and allowing one to suspend a graphical session and reconnect to it later. You can also connect to CDF's NX server from any CDF workstation or Information Commons workstation using a specially crafted profile."
        descriptionLabel.setLineHeight(1.1)
        insetView.addSubview(descriptionLabel)
        
        let viewsDict: [String: AnyObject] = [
            "titleLabel": titleLabel,
            "descriptionLabel": descriptionLabel
        ]
        
        let metricsDict: [String: AnyObject] = [
            "cellPadding": CLTable.cellPadding
        ]
        
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[titleLabel]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[descriptionLabel]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-14-[titleLabel]-[descriptionLabel]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        return insetView
    }

    override func setSelected(selected: Bool, animated: Bool) {
        // Do nothing
    }

    override func setHighlighted(highlighted: Bool, animated: Bool) {
        // Do nothing
    }
}
