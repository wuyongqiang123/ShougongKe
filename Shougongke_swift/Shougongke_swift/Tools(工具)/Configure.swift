//
//  Configure.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//
//  全局公用属性
import UIKit


public let AppWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let AppHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
public let MainBounds: CGRect = UIScreen.mainScreen().bounds
public let VCHeight = CGRectMake(0, 0, AppWidth, AppHeight-64-50-40)

public let MenuItemTagAdd = 1000
public let MenuCellHeight = 40.0
public let dyMenuCollectionCellIdentifier = "YYMenuCollectionCell"
public let LineColor = UIColor.lightGrayColor()
public let CollectionViewBgColor = UIColor.whiteColor()
public let ItemBgColor = UIColor.init(red: 241.0/255.0, green: 242.0/255.0, blue: 244.0/255.0, alpha: 1.0)
public let BgViewColor = UIColor.init(white: 0, alpha: 0.5)

struct theme {
    ///  APP导航条barButtonItem文字大小
    static let SDNavItemFont: UIFont = UIFont.systemFontOfSize(16)
    ///  APP导航条titleFont文字大小
    static let SDNavTitleFont: UIFont = UIFont.systemFontOfSize(18)
}

//请求地址
public let BASEURL = "http://m.shougongke.com"
public let SGKApiKeyCourseCategory = "http://m.shougongke.com/index.php?c=Course&a=getBaseData&vid=16"



//静态就交换静态，实例方法就交换实例方法(runtime)
func Swizzle(c: AnyClass,origSEL: Selector,newSEL: Selector)
{
    var origMethod: Method = class_getInstanceMethod(c, origSEL)
    var newMethod: Method? = nil
    if (origMethod == nil) {
        origMethod = class_getClassMethod(c, origSEL)
        if (origMethod == nil) {
            return
        }
        newMethod = class_getClassMethod(c, newSEL)
        if (newMethod == nil) {
            return
        }
    }
    else {
        newMethod = class_getInstanceMethod(c, newSEL)
        if (newMethod == nil) {
            return
        }
    }
    //自身已经有了就添加不成功，直接交换即可
    if class_addMethod(c, origSEL, method_getImplementation(newMethod!), method_getTypeEncoding(newMethod!)) {
        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))
    }
    else {
        method_exchangeImplementations(origMethod, newMethod!)
    }
}