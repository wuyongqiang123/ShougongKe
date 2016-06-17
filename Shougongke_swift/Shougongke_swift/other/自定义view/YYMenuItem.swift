//
//  YYMenuItem.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/16.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class YYMenuItem: UIButton {

    var indicatorImageView: UIImageView?
    var selectedIndex: NSInteger? = 0

    override func layoutSubviews() {
        super.layoutSubviews()
        let selfFrame: CGRect = self.frame
        var imageFame: CGRect = self.imageView!.frame
        imageFame.origin.x = selfFrame.size.width - imageFame.size.width - 8
        self.imageView!.frame = imageFame
        let titleCenter: CGPoint = CGPointMake(imageFame.origin.x / 2, self.titleLabel!.center.y)
        self.titleLabel!.center = titleCenter
    }

}
