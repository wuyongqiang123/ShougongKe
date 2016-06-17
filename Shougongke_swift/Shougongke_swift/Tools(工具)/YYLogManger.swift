//
//  YYLogManger.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import Foundation
/**
 swift自定义Log
 - parameter message:    需要打印的内容
 - parameter file:     获取方法调用者所在的文件路径
 - parameter function: 获取方法调用者所在的方法名
 - parameter line:     获取所在的行数
 */

func YYLogs<T>(message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line)
{
    #if DEBUG
        let str : String = (fileName as NSString).pathComponents.last!.stringByReplacingOccurrencesOfString("swift", withString: "")
        print("\(str)\(methodName)[\(lineNumber)]:\(message)")
    #endif
}