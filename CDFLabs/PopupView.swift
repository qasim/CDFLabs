//
//  PopupView.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 1/6/16.
//  Copyright © 2016 Qasim Iqbal. All rights reserved.
//

import UIKit
import KLCPopup

class PopupView: UIView {

    private typealias `this` = PopupView

    static var popupView: PopupView?
    static var popup: KLCPopup?

    var titleLabel: UILabel?
    var infoLabel: UILabel?
    var button: UIButton?

    init() {
        super.init(frame: CGRect(
            x: 0,
            y: 0,
            width: 320,
            height: 208))

        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 12

        self.titleLabel = UILabel()
        self.titleLabel!.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel!.textColor = UIColor.blackColor()
        self.titleLabel!.font = UIFont.systemFontOfSize(22.0, weight: UIFontWeightSemibold)
        self.titleLabel!.textAlignment = .Center
        self.addSubview(self.titleLabel!)

        self.infoLabel = UILabel()
        self.infoLabel!.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel!.textColor = UIColor.blackColor()
        self.infoLabel!.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightLight)
        self.infoLabel!.textAlignment = .Center
        self.infoLabel!.lineBreakMode = .ByWordWrapping
        self.infoLabel!.numberOfLines = 0
        self.addSubview(self.infoLabel!)

        self.button = UIButton(type: UIButtonType.RoundedRect)
        self.button!.translatesAutoresizingMaskIntoConstraints = false
        self.button!.setTitle("Continue", forState: UIControlState.Normal)
        self.button!.backgroundColor = UIColor.cdfBlueColor()
        self.button!.layer.cornerRadius = 6
        self.button!.tintColor = UIColor.whiteColor()
        self.button!.titleLabel!.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightSemibold)
        self.button!.addTarget(self, action: #selector(self.hide), forControlEvents: .TouchUpInside)
        self.addSubview(self.button!)

        let paddingView = UIView()
        paddingView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(paddingView)

        let viewsDict: [String: AnyObject] = [
            "titleLabel": self.titleLabel!,
            "infoLabel": self.infoLabel!,
            "button": self.button!,
            "paddingView": paddingView
        ]

        let metricsDict: [String: AnyObject] = [:]

        let options = NSLayoutFormatOptions(rawValue: 0)

        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-16-[titleLabel]-16-|", options: options, metrics: metricsDict, views: viewsDict))

        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-20-[infoLabel]-20-|", options: options, metrics: metricsDict, views: viewsDict))

        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-20-[button]-20-|", options: options, metrics: metricsDict, views: viewsDict))

        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[titleLabel]-12-[infoLabel][paddingView(>=1)]-12-[button(40)]-16-|", options: options, metrics: metricsDict, views: viewsDict))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func hide() {
        this.popup!.dismiss(true)
    }

    static func ensureInstance() {
        if this.popup == nil {
            this.popupView = PopupView()
            this.popup = KLCPopup(contentView: this.popupView!)
            this.popup!.showType = .BounceInFromTop
            this.popup!.dismissType = .FadeOut
        }
    }

    static func showFirstLaunchPopup() {
        this.ensureInstance()
        this.popupView!.titleLabel!.text = "Welcome to CDF Labs!"
        this.popupView!.infoLabel!.text = "Use this app to check the availability of CDF computers and printer queues at the University of Toronto."
        this.popupView!.button!.setTitle("Continue", forState: UIControlState.Normal)
        this.popupView!.infoLabel!.setLineHeight(1.1)
        this.popup!.show()
    }

    static func showFirstPrintersLaunchPopup() {
        this.ensureInstance()
        this.popupView!.titleLabel!.text = "See who's printing..."
        this.popupView!.infoLabel!.text = "Tap on a printer to view detailed queue information."
        this.popupView!.button!.setTitle("I'll try it out", forState: UIControlState.Normal)

        var frame = this.popupView!.frame
        frame.size.height = 176
        this.popupView!.frame = frame

        this.popup!.show()
    }
}
