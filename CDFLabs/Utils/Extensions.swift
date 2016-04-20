//
//  UIImage+CDFLabs.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/29/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit

extension UIColor {
    
    public class func cdfBlueColor() -> UIColor {
        return UIColor(red: 70 / 255, green: 147 / 255, blue: 208 / 255, alpha: 1.0)
    }
    
    public class func cdfDisabledBlueColor() -> UIColor {
        return UIColor(red: 179 / 255, green: 211 / 255, blue: 236 / 255, alpha: 1.0)
    }
    
    public class func cdfGreyColor() -> UIColor {
        return UIColor(red: 238 / 255, green: 238 / 255, blue: 238 / 255, alpha: 1.0)
    }
    
    public class func cdfGreenColor() -> UIColor {
        return UIColor(red: 0, green: 191 / 255, blue: 118 / 255, alpha: 1.0)
    }
    
    public class func cdfYellowColor() -> UIColor {
        return UIColor(red: 222 / 255, green: 160 / 255, blue: 86 / 255, alpha: 1.0)
    }
    
    public class func cdfRedColor() -> UIColor {
        return UIColor(red: 191 / 255, green: 63 / 255, blue: 0, alpha: 1.0)
    }
}

extension String {
    
    var titleCaseString: String {
        var s = self
        s.replaceRange(s.startIndex...s.startIndex, with: String(s[s.startIndex]).capitalizedString)
        return s
    }
    
    func replace(target: String, withString: String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }

    func calculatedWidth(font: UIFont) -> CGFloat {
        let boundingBox = self.boundingRectWithSize(
            CGSize(width: 320, height: 64),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font], context: nil)

        return ceil(boundingBox.width)
    }
}

extension UIImageView {
    
    var fittedSize: CGSize {
        let imgSize = self.image?.size
        let desiredWidth = UIScreen.mainScreen().bounds.size.width - (2 * CLTable.cellPadding) - 32
        
        let ratio = desiredWidth / imgSize!.width
        let desiredHeight = ratio * imgSize!.height
        
        return CGSize(width: desiredWidth, height: desiredHeight)
    }
}

extension UILabel {
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment

        let attrString = NSMutableAttributedString(string: self.text!)
        attrString.addAttribute(NSFontAttributeName, value: self.font, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}

extension NSUserDefaults {
    func isFirstLaunch() -> Bool {
        return true
        if !NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedBefore") {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedBefore")
            NSUserDefaults.standardUserDefaults().synchronize()
            return true
        }
        return false
    }

    func isFirstPrintersLaunch() -> Bool {
        return true
        if !NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedPrintersBefore") {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedPrintersBefore")
            NSUserDefaults.standardUserDefaults().synchronize()
            return true
        }
        return false
    }
}
