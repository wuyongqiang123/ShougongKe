//
//  UIColor+color.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/21.
//  Copyright © 2016年 wyq. All rights reserved.
//

import Foundation




//Swift 16进制颜色值转换为UIColor
extension UIColor {

    //设置color 16进制的
    class func colorWithHexString (hex:String,alphas: CGFloat) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString

        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }

        if (cString.characters.count != 6) {
            print("色值不对,返回莫认的白色")
            return UIColor.whiteColor()
        }


        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)

        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)


        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alphas)
    }
}