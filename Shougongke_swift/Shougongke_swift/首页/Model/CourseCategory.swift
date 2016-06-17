//
//  CourseCategory.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/16.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class CourseCategory: NSObject {

    var cate_id: String?
    var material: [CourseMaterial]?
    var cate_name: String?
    var ico: String?
    var cate_ico: String?
    var tools: [CourseTools]?


}

class CourseTools: NSObject {

    var tools_name: String?
    var cate_id: String?
    var tools_id: String?
}
class CourseMaterial: NSObject {

    var cate_id: String?
    var material_name: String?
    var material_id: String?
}