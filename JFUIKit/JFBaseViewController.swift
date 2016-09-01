//
//  JFBaseViewController.swift
//  JFUIKit
//
//  Created by qitmac000260 on 16/8/31.
//  Copyright © 2016年 jinfeng.du. All rights reserved.
//

import UIKit

class JFBaseViewController: UIViewController, JFLoadBlockPtc {
    
    private var blockView:JFLoadBlockView?
    
    // 内存相关
    //MARK: - Memory manager (init, dealloc ...)
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 类生命周期相关的
    //MARK:  - Life cycle (viewDidLoad ...)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // 类的internal方法(默认为此级别)
    //MARK:  - internal methods (default)
    
    /**
     展示Loading界面
     
     - parameter connectOrNil:  网络句柄，可以为空
     - parameter hintTextOrNil: 展示的loading界面内容 （默认：努力加载中...）
     - parameter cancel:        是否支持右上角的X关闭 （默认：true）
     */
    func startLoadBlock(connect connectOrNil: AnyObject?, hint hintTextOrNil: String?="努力加载中...", canCancel cancel: Bool=true) {
        if (blockView == nil) {
//            blockView = JFLoadBlockView(delegate: self, hint: hintTextOrNil!, canCancel: cancel)
            blockView = JFLoadBlockView()
            blockView?.delegate = self
        }
        
        if (self.view.subviews.contains(blockView!) == false) {
            blockView?.showInView(self.view, connect: connectOrNil, text: hintTextOrNil, cancel: cancel)
        }
    }
    
    /**
     关闭Loading界面
     */
    func stopLoadBlock() -> Void {
        self.blockView?.dismiss()
    }
    
    
    /**
     展示Loading界面,关闭状态有失败和成功两种样式（失败界面有重试按钮）
     
     - parameter connectOrNil: 网络句柄，可以为空
     */
    func startLoadEmpty(connect connectOrNil: AnyObject?) -> Void {
        
    }
    
    /**
     展示失败/重试界面
     */
    func stopAndLoadEmptyError() -> Void {
        
    }
    
    /**
     关闭Loading界面
     */
    func stopLoadEmpty() -> Void {
        
    }
    
    // 所有的Actions
    //MARK:  - Actions
    
    // 通知回调，具体可以细分
    //MARK:  - Notifications - XXX
    
    // 系统的Delegate
    //MARK:  - UITableViewDelegate
    
    // 自定义类的Delegate
    //MARK:  - XXXDelegate
    
    // 自定义View、初始化等
    //MARK:  - Custom views
    
    // 类私有方法
    //MARK:  - Private methods

}
