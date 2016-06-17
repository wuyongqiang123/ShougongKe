
import Foundation
#if DEBUG

//(arch(x86_64) || arch(i386))
    
@objc(EADebugWindow)
    
class EADebugWindow : UIWindow {
    
    struct _IMP {
        static let debugWindow = EADebugWindow(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 20))
    }
    
    class func createDebugWindow()->EADebugWindow {
        return _IMP.debugWindow
    }
    
    internal var debugSkinPath : String?;
    
    func setSkinPath(relativePath:String, absolutePath:String=#file) {
        
        debugSkinPath = NSURL(string: absolutePath)?.URLByDeletingLastPathComponent?.URLByAppendingPathComponent(relativePath).absoluteString
        SkinMgr.sharedInstance().skinPath = self.debugSkinPath
    }
    
    override init(frame:CGRect) {
        
        super.init(frame: frame)
        
        let vc = UIViewController()
        vc.view.frame = frame
        self.rootViewController = vc
        
        let button = UIButton(frame: self.bounds)
        button.addTarget(self, action: #selector(EADebugWindow.switchSkinDebug(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        vc.view.addSubview(button)
        button.tag = 8001
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.userInteractionEnabled = true
        self.windowLevel = 2000
        
        let button1 = UIButton(frame: CGRectMake(0, 0, 80, 20))
        button1.setTitle("自动刷新", forState: UIControlState.Normal)
        button1.setTitle("关闭刷新", forState: UIControlState.Selected);
        button1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button1.addTarget(self, action: #selector(EADebugWindow.switchRefresh(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button1.backgroundColor = UIColor.greenColor()
        button.addSubview(button1)
        button1.hidden = true
        button1.tag = 81001
        
//        #if (arch(armv7) || arch(armv7s) || arch(arm64))
//            button1.selected = true
//        #endif
        
        let button2 = UIButton(frame: CGRectMake(80, 0, 80, 20))
        button2.setTitle("刷一下", forState: UIControlState.Normal)
        button2.addTarget(self, action: #selector(EADebugWindow.refresh(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button2.backgroundColor = UIColor.blueColor()
        button2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.addSubview(button2)
        button2.hidden = true
        button2.tag = 81002
        
        let label = UILabel(frame: self.bounds)
        vc.view.addSubview(label)
        label.textColor = UIColor.blackColor()
        label.text = "1"
        label.tag = 7001
        label.hidden = true
        label.textAlignment = NSTextAlignment.Right
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func switchRefresh(button:UIButton) {
        button.selected = !button.selected
        if button.selected {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "debugSkin")
            autoRefresh()
            self.viewWithTag(81002)?.hidden = true
        } else {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "debugSkin")
            autoRefresh()
            self.viewWithTag(81002)?.hidden = false
        }
    }
    
    func refresh(button:UIButton) {
        button.selected = !button.selected
        NSUserDefaults.standardUserDefaults().setBool(button.selected, forKey: "debugSkin")
        tick()
        
        let label = (self.viewWithTag(7001) as! UILabel)
        let value = Int(label.text!)! + 1
        label.text = "\(value)"
    }
    
    func switchSkinDebug(button:UIButton) {

        button.selected = !button.selected
        
        if button.selected {
            self.backgroundColor = UIColor.yellowColor()
            button.viewWithTag(81001)?.hidden = false
            button.viewWithTag(81002)?.hidden = false
            self.viewWithTag(7001)?.hidden = false
        } else {
            self.backgroundColor = nil
            button.viewWithTag(81001)?.hidden = true
            button.viewWithTag(81002)?.hidden = true
            (button.viewWithTag(81001) as! UIButton).selected = false
            self.viewWithTag(7001)?.hidden = true
        }
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "debugSkin")
        autoRefresh()
    }
    
    func autoRefresh() {
        if(NSUserDefaults.standardUserDefaults().boolForKey("debugSkin"))
        {
            if nil == timer {
                var ds : NSTimeInterval = 2
                #if (arch(x86_64) || arch(i386))
                    ds = 1
                #endif
                timer = NSTimer.scheduledTimerWithTimeInterval(ds, target: self, selector: #selector(EADebugWindow.tick), userInfo: nil, repeats: true)
            }
        }
        else
        {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func tick() {
        if(NSUserDefaults.standardUserDefaults().boolForKey("debugSkin"))
        {
//            let rootVC = UIApplication.sharedApplication().windows[0].rootViewController
//            if let navi = rootVC as? UINavigationController {
//                (navi.topViewController as? BaseViewController)?.freshSkin()
//            }


            YYLogs(UIViewController.YY_currentTopViewController())
            (UIViewController.YY_currentTopViewController() as! BaseViewController).freshSkin()
//            else {
//                (rootVC as? BaseViewController)?.freshSkin()
//            }
        }
        else
        {
            timer?.invalidate()
            timer = nil
        }
    }
    
    var timer : NSTimer?
}
    #endif



