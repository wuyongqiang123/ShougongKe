//
//  YYMenuCollectionViewCell.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/16.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class YYMenuCollectionViewCell: UICollectionViewCell {

   
    lazy var titleImgView: UIImageView? = {
        let img = UIImageView.init(frame: CGRectMake(20, 0, 20, 20))
        return img
    }()
    lazy var title_lab: UILabel? = {
        let lab = UILabel.init(frame: CGRectMake((self.titleImgView?.right)!+10, 0, 80, 20))
        lab.font = UIFont.systemFontOfSize(14, weight: UIFontWeightThin)
        lab.textColor = UIColor.darkGrayColor()
        lab.textAlignment = NSTextAlignment.Left
        return lab
    }()
    func configuraCellWith(model: YYMenuDataModel) {
        self.title_lab?.text = model.titles
        if (model.imgNames != "") {
            self.titleImgView?.image = UIImage.init(named: model.imgNames!)
        }
        else {
            let str = model.imgUrls!
            self.titleImgView?.kf_setImageWithURL(NSURL(string: str)!)
        }
    }

  override  init(frame: CGRect) {
        super.init(frame: frame)
    self.backgroundColor = UIColor.whiteColor()
    self.contentView.addSubview(self.titleImgView!)
    self.contentView.addSubview(self.title_lab!)

    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
