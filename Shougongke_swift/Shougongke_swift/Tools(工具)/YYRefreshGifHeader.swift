//
//  YYRefreshGifHeader.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//  下拉刷新自定义图片
//  上拉使用默认的

import UIKit

class YYRefreshGifHeader: XWRefreshGifHeader {

    class func addRefreshHeaderWithRrefreshingBlock(refreshingBlock: XWRefreshComponentRefreshingClosure)-> YYRefreshGifHeader {
        let header = YYRefreshGifHeader.init(ComponentRefreshingClosure: refreshingBlock)
        header.automaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel.hidden = true
        header.stateLabel.font = UIFont.systemFontOfSize(11)
        header.stateLabel.textColor = UIColor.lightGrayColor()
        header.setTitle("下拉刷新", state: .Idle)
        header.setTitle("松开刷新", state: .Pulling)
        header.setTitle("小客正在刷新", state: .Refreshing)
        return header
    }

    override func prepare() {
        super.prepare()
        // 设置即将刷新状态和默认的动画图片
        var idleImages = [UIImage]()
        for i in 0..<4 {
            let image = UIImage(named: String(format: "refresh00%zd", i+1))
            idleImages.append(image!)
        }
        self.setImages(idleImages,duration: 0.4, state: .Idle)
        self.setImages(idleImages,duration: 0.4, state: .Pulling)
    }

    override func placeSubvies() {
        super.placeSubvies()
        
    }

}
