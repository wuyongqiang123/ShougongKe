//
//  ArrangeTagsCell.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/19.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class ArrangeTagsCell: UICollectionViewCell {

    var titleLabel:UILabel?//cell上title

    override init(frame: CGRect) {

        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()
        //初始化各种控件
        titleLabel = UILabel(frame: CGRectMake(0, 0, self.width, 30))
        titleLabel?.textAlignment = NSTextAlignment.Center
        titleLabel?.font = UIFont.boldSystemFontOfSize(14.0)
        titleLabel?.textColor = UIColor.lightGrayColor()
        self .addSubview(titleLabel!)


        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
