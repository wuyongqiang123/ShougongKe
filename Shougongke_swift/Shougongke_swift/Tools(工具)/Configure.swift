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
public let VCHeight = CGRectMake(0, 0, AppWidth, AppHeight-64-50-44)

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