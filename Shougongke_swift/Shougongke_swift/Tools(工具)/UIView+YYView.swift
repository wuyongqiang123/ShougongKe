//
//  UIView+YYView.swift
//  Beibei
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 wyq. All rights reserved.
//

import Foundation


/// 对UIView的扩展
extension UIView{

    var left: CGFloat {
        // get方法
        // 需要注意的是:写了set,get是必须写的,如果只写get,相当于只读.
        get {
            return self.frame.origin.x
        }
        // set 方法
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }

    var top: CGFloat {

        get {
            return self.frame.origin.y
        }

        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }

    var right: CGFloat {

        get {
            return self.frame.origin.x + self.frame.size.width
        }

        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width;
            self.frame = frame;
        }
    }

    var bottom: CGFloat {

        get {
            return self.frame.origin.y + self.frame.size.height
        }

        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height;
            self.frame = frame;
        }
    }

    var centerX: CGFloat {

        get {
            return self.center.x
        }

        set {
            self.center = CGPointMake(newValue, self.center.y)
        }
    }

    var centerY: CGFloat {

        get {
            return self.center.y
        }

        set {
            self.center = CGPointMake(self.center.x, newValue)
        }
    }

    var width: CGFloat {

        get {
            return self.frame.size.width
        }

        set {
            var frame = self.frame
            frame.size.width = newValue;
            self.frame = frame;
        }
    }

    var height: CGFloat {

        get {
            return self.frame.size.height
        }

        set {
            var frame = self.frame
            frame.size.height = newValue;
            self.frame = frame;
        }
    }

    var origin: CGPoint {

        get {
            return self.frame.origin
        }

        set {
            var frame = self.frame
            frame.origin = newValue;
            self.frame = frame;
        }
    }

    var size: CGSize {

        get {
            return self.frame.size
        }
        
        set {
            var frame = self.frame
            frame.size = newValue;
            self.frame = frame;
        }
    }
    
    
    
    
}