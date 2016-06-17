//
//  YYMenuDataModel.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/16.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class YYMenuDataModel: NSObject {

    var titles: String?
    var imgNames: String?
    var imgUrls: String?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(title: String,name: String, url: String) {
        super.init()
        self.imgNames = name
        self.titles = title
        self.imgUrls = url
    }

}
