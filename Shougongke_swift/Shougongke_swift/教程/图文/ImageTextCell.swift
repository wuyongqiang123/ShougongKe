//
//  ImageTextCell.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/21.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class ImageTextCell: UICollectionViewCell {

    var titleLabel:UILabel?//cell上title
    var titleName: UILabel?
    var titleOther: UILabel?
    var backgdView: UIView?
    var lineView: UIView?
    var bgImageView: UIImageView?

    override init(frame: CGRect) {

        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true

        bgImageView = UIImageView.init(frame:CGRectMake(0, 0, self.width, self.height))
        bgImageView?.image = UIImage.init(named: "newfeature_01")
        self.contentView.addSubview(bgImageView!)

        backgdView = UIView.init(frame: CGRectMake(0, 115, self.width, 85))
        backgdView?.backgroundColor = UIColor.lightGrayColor()
        bgImageView!.addSubview(backgdView!)


        //初始化各种控件
        titleLabel = UILabel(frame: CGRectMake(10, 10, self.width-20, 20))
        titleLabel?.textAlignment = NSTextAlignment.Left
        titleLabel?.font = UIFont.boldSystemFontOfSize(14.0)
        titleLabel?.textColor = UIColor.whiteColor()
        backgdView!.addSubview(titleLabel!)

        titleName = UILabel(frame: CGRectMake(10, (self.titleLabel?.bottom)!+3, self.width-20, 20))
        titleName?.textAlignment = NSTextAlignment.Left
        titleName?.font = UIFont.boldSystemFontOfSize(14.0)
        titleName?.textColor = UIColor.init(white: 1, alpha: 0.5)
        backgdView!.addSubview(titleName!)

        lineView = UIView.init(frame: CGRectMake(10, (self.titleName?.bottom)!+3, self.width-20, 1))
        lineView?.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        backgdView?.addSubview(lineView!)


        titleOther = UILabel(frame: CGRectMake(10, (self.lineView?.bottom)!+3, self.width-20, 20))
        titleOther?.textAlignment = NSTextAlignment.Left
        titleOther?.font = UIFont.boldSystemFontOfSize(14.0)
        titleOther?.textColor = UIColor.init(white: 1, alpha: 0.5)
        backgdView!.addSubview(titleOther!)




    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
