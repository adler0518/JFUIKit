//
//  ViewController.swift
//  JFUIKit
//
//  Created by qitmac000260 on 16/8/31.
//  Copyright © 2016年 jinfeng.du. All rights reserved.
//

import UIKit

class ViewController: JFBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func cancelLoadForContext(context contextOrNil: AnyObject?) {
        print("vc loadblock delegate \(contextOrNil)")
    }
    
    @IBAction func showLoadBlockViewActin(sender:UIButton) {
        self.startLoadBlock(connect: nil)
        
        let delay = dispatch_time(DISPATCH_TIME_NOW,
                                  Int64(3 * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            print("3 秒后输出")
            self.stopLoadBlock()
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
            Int64(1 * Double(NSEC_PER_SEC))),
                       dispatch_get_main_queue()) {
                        print("new loading")
                        self.startLoadBlock(connect: nil)
        }
    }
    
    @IBAction func showLoadEmptyViewActin(sender:UIButton) {
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: "提示", message: "UIAlertController 预期支持网络失败重试的Loading", preferredStyle: .Alert)
            let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertView(title: "提示", message: "UIAlertView 预期支持网络失败重试的Loading", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
        }
    }

}

