//
//  LoginViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/20.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        let item = UIBarButtonItem.init(leftimageName: "", highlImageName: "", targer: self, action: nil)
        self.navigationItem.leftBarButtonItem = item
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
