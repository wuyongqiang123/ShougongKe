//
//  BaseNavigationController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationBar.barTintColor =
            UIColor.init(colorLiteralRed: 235.0/255.0, green: 87.0/255.0, blue: 84.0/255.0, alpha: 1.0)
    }

    override func shouldAutorotate() -> Bool {
        return (self.visibleViewController?.shouldAutorotate())!
    }
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return (self.visibleViewController?.preferredInterfaceOrientationForPresentation())!
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if !(self.visibleViewController?.isKindOfClass(UIAlertController))! {
            return (self.visibleViewController?.supportedInterfaceOrientations())!

        }
        else {
            return UIInterfaceOrientationMask.Portrait
        }
    }

}
