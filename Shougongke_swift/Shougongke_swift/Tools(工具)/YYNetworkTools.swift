//
//  YYNetworkTools.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/16.
//  Copyright © 2016年 wyq. All rights reserved.
//  请求封装

import UIKit
import Alamofire
//回调闭包
 typealias HTTPRequestHandler = (responseObject: AnyObject?, error: NSError?) -> Void
 class YYNetworkTools: NSObject {

    //请求方式
     enum Method : String {
        case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
        var alamofireMethod: Alamofire.Method {
            var results = Alamofire.Method.GET
            switch self {
            case .GET:
                results = Alamofire.Method.GET
            case .POST:
                results = Alamofire.Method.POST
            case .HEAD:
                results = Alamofire.Method.HEAD
            case .OPTIONS:
                results = Alamofire.Method.OPTIONS
            case .PUT:
                results = Alamofire.Method.PUT
            case .PATCH:
                results = Alamofire.Method.POST
            case .DELETE:
                results = Alamofire.Method.DELETE
            case .TRACE:
                results = Alamofire.Method.TRACE
            case .CONNECT:
                results = Alamofire.Method.CONNECT
            }
            return results
        }
    }

    /**
     data请求
     - parameter method:             方法类型
     - parameter url:                URL
     - parameter param:              参数
     - parameter complectionHandler: 回调
     */
     class func dataRequest(method: Method, urlString url: URLStringConvertible, parameter param: [String : AnyObject]?, complectionHandler: HTTPRequestHandler?) {

        /*
         public func request(method: Method, _ URLString: URLStringConvertible, parameters: [String: AnyObject]? = nil, encoding: ParameterEncoding = .URL, headers: [String: String]? = nil) -> Request
         */
        let req = Alamofire.request(method.alamofireMethod, url, parameters: param, encoding: .URL, headers: nil)
        req.responseJSON { (resp) -> Void in
            if resp.result.isSuccess {
                if let handler = complectionHandler {
                    handler(responseObject: resp.result.value, error: nil)
                }
            } else {
                if let handler = complectionHandler {
                    handler(responseObject: nil, error:resp.result.error)
                }
            }
        }
    }


}


