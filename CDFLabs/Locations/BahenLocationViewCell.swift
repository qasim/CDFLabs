//
//  BahenLocationView.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 1/5/16.
//  Copyright © 2016 Qasim Iqbal. All rights reserved.
//

import UIKit

class BahenLocationViewCell: UITableViewCell {
    
    init() {
        super.init(style: .Default, reuseIdentifier: "Bahen")
        
        self.backgroundColor = UIColor.cdfGreyColor()
        
        let insetView = self.createInsetView()
        self.addSubview(insetView)
        
        let viewsDict: [String: AnyObject] = [
            "insetView": insetView
        ]
        
        let metricsDict: [String: AnyObject] = [
            "cellPadding": CLTable.cellPadding
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
        let insetView = UIView(frame: UIScreen().bounds)
        insetView.translatesAutoresizingMaskIntoConstraints = false
        insetView.backgroundColor = UIColor.whiteColor()
        insetView.layer.cornerRadius = CLTable.cellCornerRadius
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.systemFontOfSize(24.0, weight: UIFontWeightLight)
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.text = "Bahen Centre for Information Technology"
        insetView.addSubview(titleLabel)
        
        let locationPinIcon = UIImageView(image: UIImage(named: "LocationPinIcon"))
        locationPinIcon.translatesAutoresizingMaskIntoConstraints = false
        insetView.addSubview(locationPinIcon)
        
        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textColor = UIColor.grayColor()
        locationLabel.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightLight)
        let tapListener = UITapGestureRecognizer(target: self, action: #selector(self.openMaps))
        tapListener.numberOfTapsRequired = 1
        locationLabel.addGestureRecognizer(tapListener)
        locationLabel.userInteractionEnabled = true
        locationLabel.text = "40 St George Street, Toronto, ON M5S 2E4"
        insetView.addSubview(locationLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = UIColor.blackColor()
        descriptionLabel.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightLight)
        descriptionLabel.lineBreakMode = .ByWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "The Bahen Centre hosts the majority of the CDF labs, highlighted below."
        descriptionLabel.setLineHeight(1.1)
        insetView.addSubview(descriptionLabel)
        
        let secondFloorLabel = UILabel()
        secondFloorLabel.translatesAutoresizingMaskIntoConstraints = false
        secondFloorLabel.textColor = UIColor.grayColor()
        secondFloorLabel.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightLight)
        secondFloorLabel.text = "Second floor"
        insetView.addSubview(secondFloorLabel)

        let secondFloorImage = UIImageView(image: UIImage(named: "BahenSecondFloor"))
        secondFloorImage.translatesAutoresizingMaskIntoConstraints = false
        secondFloorImage.contentMode = .ScaleAspectFit
        insetView.addSubview(secondFloorImage)
        
        let thirdFloorLabel = UILabel()
        thirdFloorLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdFloorLabel.textColor = UIColor.grayColor()
        thirdFloorLabel.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightLight)
        thirdFloorLabel.text = "Third floor"
        insetView.addSubview(thirdFloorLabel)
        
        let thirdFloorImage = UIImageView(image: UIImage(named: "BahenThirdFloor"))
        thirdFloorImage.translatesAutoresizingMaskIntoConstraints = false
        thirdFloorImage.contentMode = .ScaleAspectFit
        insetView.addSubview(thirdFloorImage)
        
        let viewsDict: [String: AnyObject] = [
            "insetView": insetView,
            "titleLabel": titleLabel,
            "locationPinIcon": locationPinIcon,
            "locationLabel": locationLabel,
            "descriptionLabel": descriptionLabel,
            "secondFloorLabel": secondFloorLabel,
            "secondFloorImage": secondFloorImage,
            "thirdFloorLabel": thirdFloorLabel,
            "thirdFloorImage": thirdFloorImage
        ]
        
        let metricsDict: [String: AnyObject] = [
            "cellPadding": CLTable.cellPadding,
            "cellHeight": CLTable.cellHeight,
            "secondFloorHeight": secondFloorImage.fittedSize.height + 32,
            "thirdFloorHeight": thirdFloorImage.fittedSize.height + 32
        ]
        
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[titleLabel]-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[locationPinIcon]-[locationLabel]", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[titleLabel]-10-[locationPinIcon]", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[descriptionLabel]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[secondFloorLabel]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[secondFloorImage]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[thirdFloorLabel]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[thirdFloorImage]-16-|", options: options, metrics: metricsDict, views: viewsDict))
        
        insetView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-14-[titleLabel]-cellPadding-[locationLabel]-[descriptionLabel]-32-[secondFloorLabel]-[secondFloorImage(secondFloorHeight)]-32-[thirdFloorLabel]-[thirdFloorImage(thirdFloorHeight)]|", options: options, metrics: metricsDict, views: viewsDict))
        
        return insetView
    }
    
    func openMaps() {
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "comgooglemaps://")!) {
            UIApplication.sharedApplication().openURL(NSURL(string:
                "comgooglemaps://?q=Bahen+Centre+for+Information+Technology")!)
        } else {
            UIApplication.sharedApplication().openURL(NSURL(string:
                "http://maps.apple.com/?q=Bahen+Centre+for+Information+Technology")!)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        // Do nothing
    }

    override func setHighlighted(highlighted: Bool, animated: Bool) {
        // Do nothing
    }
}
