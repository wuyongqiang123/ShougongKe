//
//  ZPLine.swift
//  ZPLine
//
//  Created by wyq on 16/4/7.
//  Copyright © 2016年 wyq. All rights reserved.
//https://github.com/wuyongqiang123/ZPLine
//添加线
import UIKit

enum ZPDirection : Int {
    case Top
    case Bottom
    case Left
    case Right
}

struct ZPPading {
    var left : CGFloat
    var right : CGFloat
    var top : CGFloat
    var bottom : CGFloat
};

let ZPLineTopTag: Int = 23333 + 1
let ZPLineBottomTag: Int = 23333 + 2
let ZPLineLeftTag: Int = 23333 + 3
let ZPLineRightTag: Int = 23333 + 4

//定义私有结构体,目的是为了防止命名污染整个命名空间
private struct AssociatedKeys{
    static let kDTActionHandlerTapGestureKey = "kWebImageKey"
}


extension UIView{

    ///显示某个方向的线（上下左右）
    func showLineForHorizontalWithLeftPad(pad: CGFloat) {
        self.showLineForDirection(.Top, pading: ZPPading(left: pad, right: 0, top: 0, bottom: 0))
        self.showLineForDirection(.Bottom, pading: ZPPading(left: pad, right: 0, top: 0, bottom: 0))
    }
    ///显示某个方向的线，间距是padding
    func showLineForDirection(direction: ZPDirection, leftPad pad: CGFloat) {
        self.showLineForDirection(direction, pading: ZPPading(left: pad, right: 0, top: 0, bottom: 0))
    }
    ///显示某方向的线和左边间距（一般是上下线）
    func showLineForDirection(direction: ZPDirection) {
        self.showLineForDirection(direction, pading: ZPPading(left: 0, right: 0, top: 0, bottom: 0))
    }
    ///显示上下线和左边间距
    func showLineForDirection(direction: ZPDirection, pading: ZPPading) {
        //线条的高度
        let onePx: CGFloat = 1 / min(UIScreen.mainScreen().scale, 2.0)
            //1 / min(UIScreen.mainScreen().scale, 2.0)

        //初始化
        let line: ZPLine = ZPLine()
        //根据枚举类型获取tag值
        line.tag = self.lineTagWithDirection(direction)
        switch direction {
        case .Top:
            line.autoresizingMask = [.FlexibleWidth, .FlexibleBottomMargin]
        case .Bottom:
            line.autoresizingMask = [.FlexibleWidth, .FlexibleTopMargin]
        case .Left:
            line.autoresizingMask = [.FlexibleHeight, .FlexibleRightMargin]
        case .Right:
            line.autoresizingMask = [.FlexibleHeight, .FlexibleLeftMargin]
        }

        self.addSubview(line)
        self.bringSubviewToFront(line)

        //更新位置
        switch direction {
        case .Top:
            line.frame = CGRectMake(0, 0, self.frame.width, onePx)
        case .Bottom:
            line.frame = CGRectMake(0, self.frame.height - onePx, self.frame.width, onePx)
        case .Left:
            line.frame = CGRectMake(0, 0, onePx, self.frame.height)
        case .Right:
            line.frame = CGRectMake(self.frame.width - onePx, 0, onePx, self.frame.height)
        }

        let p: CGPoint = line.frame.origin
        let s: CGSize = line.frame.size
        line.frame = CGRectMake(p.x + pading.left, p.y + pading.top, s.width - pading.left - pading.right, s.height - pading.top - pading.bottom)
    }

    ///显示垂直的线，也就是左右
    func showLineForVertical() {
        self.showLineForDirection(.Left)
        self.showLineForDirection(.Right)
    }
    ///显示水平的线，也就是上下
    func showLineForHorizontal() {
        self.showLineForDirection(.Top)
        self.showLineForDirection(.Bottom)
    }
    ///隐藏某个方向的线
    func hideLineForDirection(direction: ZPDirection) {
        let line: ZPLine = self.lineWithDirection(direction)
        line.hidden = true

    }
    ///隐藏垂直（左右）的线
    func hideLineForVertical() {
        self.hideLineForDirection(.Left)
        self.hideLineForDirection(.Right)
    }
    ///隐藏水平（上下）的线
    func hideLineForHorizontal() {
        self.hideLineForDirection(.Top)
        self.hideLineForDirection(.Bottom)
    }
    ///获取某个方向的线
    func lineWithDirection(direction: ZPDirection) -> ZPLine {
        return (self.viewWithTag(self.lineTagWithDirection(direction)) as! ZPLine)
    }
    //获取tap值
    func lineTagWithDirection(direction: ZPDirection) -> Int {
        switch direction {
        case .Top:
            return ZPLineTopTag
        case .Bottom:
            return ZPLineBottomTag
        case .Left:
            return ZPLineLeftTag
        case .Right:
            return ZPLineRightTag
        }
    }


}

class ZPLine: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //线的颜色(颜色可自己修改)
        self.backgroundColor = UIColor.lightGrayColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



