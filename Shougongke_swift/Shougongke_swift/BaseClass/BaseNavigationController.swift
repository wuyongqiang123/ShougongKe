//
//  BaseNavigationController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController,UINavigationControllerDelegate {

    var popDelegate: UIGestureRecognizerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationBar.barTintColor =
            UIColor.init(colorLiteralRed: 235.0/255.0, green: 87.0/255.0, blue: 84.0/255.0, alpha: 1.0)

        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
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

    //UINavigationControllerDelegate方法
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        //实现滑动返回功能
        //清空滑动返回手势的代理就能实现
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer!.delegate = self.popDelegate
        }
        else {
            self.interactivePopGestureRecognizer!.delegate = nil
        }
    }

}
