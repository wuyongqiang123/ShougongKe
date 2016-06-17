

import Foundation
/********************** 绑定基本数据到对象 *********************************/

//MARK: 绑定view最常用数据 UIView(bindData)

struct BD_Url
{
    init(_ url:String?)
    {
        value = url
    }
    var value : String?
}

extension UIView
{
    func bindData(data:Any?)
    {
        switch (self)
        {
        case is UILabel:
            self.bindForUILabel(data)
            
        case is UIImageView:
            self.bindForUIImageView(data)
            
        case is UIButton:
            bindForUIButton(data)
/*
        case is EAButton:
            bindForEAButton(data)
            
        case is TQRichTextView:
            bindForTQRichTextView(data)
*/
            
        default:
            break;
        }
    }
    
    func bindForUILabel(data:Any?)
    {
       let data = data ?? ""
        if let str = data as? NSString
        {
            (self as! UILabel).text = str as String
        }
    }
    
    func bindForUIImageView(data:Any?)
    {
        if nil == data || data is UIImage
        {
            (self as! UIImageView).image = data as? UIImage
        }
//        else if let url = data as? NSString 
//        {
//            (self as! UIImageView).setUrl(url)
//        }
    }
    
    func bindForUIButton(data:Any?)
    {
        if let str = data as? String
        {
            (self as! UIButton).setTitle(str, forState: UIControlState.Normal)
        }
        else if nil == data || data is UIImage
        {
            (self as! UIButton).setImage(data as? UIImage, forState: UIControlState.Normal)
        }
    }
    
//    func bindForEAButton(var data:Any?) 
//    {
//        if let str = data as? NSString 
//        {
//            (self as! EAButton).text = str.stringValue
//        } 
//        else if let url = data as? BD_Url 
//        {
//            (self as! EAButton).setUrl(url.value)
//        }
//        else if data is UIImage 
//        {
//            (self as! EAButton).image = data as? UIImage
//        }
//    }
//    
//    func bindForTQRichTextView(var data:Any?) 
//    {
//        data = data ?? ""
//        if let str = data as? NSString 
//        {
//            (self as! TQRichTextView).text = str.stringValue
//        }
//    }
    
    func bindByTag(tag:NSInteger,data:Any?)->UIView?
    {
        let subView = viewWithTag(tag)
        subView?.bindData(data)
        return subView;
    }
    
    func bindByTag(tag:String,data:Any?)->UIView?
    {
        let subView = viewWithStrTag(tag)
        subView?.bindData(data)
        return subView;
    }
}
