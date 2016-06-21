//
//  UIDevice+Public.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/21.
//  Copyright © 2016年 wyq. All rights reserved.
//

import Foundation

extension UIDevice {


    //取得IOS设备型号
    func machineInfo() -> String {
        var size : Int = 0 // as Ben Stahl noticed in his answer
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](count: Int(size), repeatedValue: 0)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String.fromCString(machine)!
    }
    //是否是模拟器或真机
    struct Platform {
        static let isSimulator: Bool = {
            var isSim = false
            #if arch(i386) || arch(x86_64)
                isSim = true
            #endif
            return isSim
        }()
    }
    //是否是模拟器
    class func isSimulator() -> Bool {
        let device: UIDevice = UIDevice.currentDevice()
        var isSimulator: Bool = device.model.rangeOfString("Simulator")?.count > 0
        if isSimulator == false {
            isSimulator = device.machineInfo().rangeOfString("x86")?.count > 0
        }
        return isSimulator
    }

}