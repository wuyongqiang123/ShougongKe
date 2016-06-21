//
//  KGStatusBar.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/21.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit
enum ApsType : Int {
    case Share
    case Point
    case Special
}

class KGStatusBar: UIView {

    var apsDict: [NSObject : AnyObject] = [:]
    lazy var overlayWindow: UIWindow? = {
        var window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        window.backgroundColor = UIColor.clearColor()
        window.userInteractionEnabled = false
        window.windowLevel = UIWindowLevelStatusBar
        return window
    }()
    lazy var topBar: UIView? = {
       let topBar = UIView(frame: CGRectMake(0, 0, self.overlayWindow!.frame.size.width, 20.0))
        self.overlayWindow!.addSubview(topBar)
        return topBar
    }()
    lazy var stringLabel: UILabel? = {

        let label = UILabel(frame: CGRectZero)
        label.textColor = UIColor(red: 191.0 / 255.0, green: 191.0 / 255.0, blue: 191.0 / 255.0, alpha: 1.0)
        label.backgroundColor = UIColor.clearColor()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .Center
        label.textAlignment = .Center
        label.baselineAdjustment = .AlignCenters
        label.font = UIFont.boldSystemFontOfSize(14.0)
        label.shadowColor = UIColor.blackColor()
        label.shadowOffset = CGSizeMake(0, -1)
        label.numberOfLines = 0
        if (label.superview == nil) {
            self.topBar!.addSubview(label)
        }
        return label
    }()

    struct Static {

        static var instance:KGStatusBar? = nil

        static var onceToken:dispatch_once_t = 0

    }
    class func sharedInstance() -> KGStatusBar! {


         //普通闭包写法

         dispatch_once(&Static.onceToken, { () -> Void in

         Static.instance = KGStatusBar.init(frame: UIScreen.mainScreen().bounds)

         })

        
        return Static.instance!
        
    }

    class func showSuccessWithStatus(status: String) {
        KGStatusBar.showWithStatus(status)
        //    [KGStatusBar performSelector:@selector(dismiss) withObject:self afterDelay:2.0 ];
    }

    class func changeStatus(status: String) {
        KGStatusBar.sharedInstance().stringLabel!.text = status
    }

    class func show() {

        KGStatusBar.sharedInstance().showWithStatus("", barColor:UIColor.colorWithHexString("0xffffff",alphas: 0.7), textColor: UIColor(red: 191.0 / 255.0, green: 191.0 / 255.0, blue: 191.0 / 255.0, alpha: 1.0))
    }

    class func changeWithStatus(status: String) {
        KGStatusBar.sharedInstance().changeText(status)
    }

    class func showWithStatus(status: String) {
        KGStatusBar.sharedInstance().showWithStatus(status, barColor: UIColor.blackColor(), textColor: UIColor(red: 191.0 / 255.0, green: 191.0 / 255.0, blue: 191.0 / 255.0, alpha: 1.0))
    }

    class func showErrorWithStatus(status: String) {
        KGStatusBar.sharedInstance().showWithStatus(status, barColor: UIColor(red: 97.0 / 255.0, green: 4.0 / 255.0, blue: 4.0 / 255.0, alpha: 1.0), textColor: UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0))
        KGStatusBar.performSelector(#selector(KGStatusBar.dismiss), withObject: self, afterDelay: 2.0)
    }

    class func dismiss() {
        KGStatusBar.sharedInstance().dismiss()
    }

     override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = false
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 0
        self.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    func showWithStatus(status: String, barColor: UIColor, textColor: UIColor) {
        if (self.superview == nil) {
            self.overlayWindow!.addSubview(self)
            self.overlayWindow!.hidden = false
        }

        self.topBar!.hidden = false
        self.topBar!.backgroundColor = barColor
        let labelText: NSString = status
        var labelRect: CGRect = CGRectZero
        var stringWidth: CGFloat = 0
        var stringHeight: CGFloat = 0
        if labelText != "" {
            let attributes = [NSFontAttributeName: self.stringLabel!.font]
            let stringSize: CGSize = labelText.sizeWithAttributes(attributes)
                //labelText.sizeWithFont(self.stringLabel!.font, constrainedToSize: CGSizeMake(self.topBar!.frame.size.width, self.topBar!.frame.size.height))
            stringWidth = stringSize.width
            stringHeight = stringSize.height
            labelRect = CGRectMake((self.topBar!.frame.size.width / 2) - (stringWidth / 2), 0, stringWidth, 20)
        }
        self.stringLabel!.font = UIFont.systemFontOfSize(11)
        self.stringLabel!.frame = labelRect
        self.stringLabel!.alpha = 0.0
        self.stringLabel!.hidden = false
        self.stringLabel!.text = labelText as String
        self.stringLabel!.textColor = textColor
        UIView.animateWithDuration(0.4, animations: {() -> Void in
            self.stringLabel!.alpha = 1.0
        })
        self.setNeedsDisplay()
    }

    func changeText(message: String) {
        //    self.stringLabel.font = TTFont(11);
        self.stringLabel!.text = message
    }

    func dismiss() {
        UIView.animateWithDuration(0.4, delay: 1, options: .TransitionCurlDown, animations: {() -> Void in
            self.topBar!.backgroundColor = UIColor.clearColor()
            self.stringLabel!.alpha = 0.0
            }, completion: {(finished: Bool) -> Void in
                self.topBar!.removeFromSuperview()
                self.overlayWindow!.removeFromSuperview()
        })
    }


}
