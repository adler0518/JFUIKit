//
//  JFLoadBlockView.swift
//  JFUIKit
//
//  Created by qitmac000260 on 16/8/31.
//  Copyright © 2016年 jinfeng.du. All rights reserved.
//

import UIKit

//default LOGTarge print("Function: \(#function) Line: \(#line)")

@objc protocol JFLoadBlockPtc {
    /**
     取消Load，通过上下文判断处理
     
     - parameter contextOrNil: 取消Load对应的上下文
     */
    optional func cancelLoadForContext(context contextOrNil: AnyObject?);
}

class JFLoadBlockView: UIView {
    let JFLoadBlockContentViewWidth = 240, JFLoadBlockContentViewHeight = 124;
    
    var delegate:JFLoadBlockPtc?                        //代理
    private var hintText:String = "努力加载中..."        //提示文本
    private var canCancel:Bool = true                   //是否可以取消
    
    private var contentView:UIView?                     //内容界面
    private var connect:AnyObject?                      //网络连接
    private var hintLabel:UILabel?                      //提示文本
    private var cancelBtn:UIButton!                     //取消按钮

    // 内存相关
    //MARK: - Memory manager (init, dealloc ...)
//    convenience init(delegate:JFLoadBlockPtc, hint:String, canCancel:Bool) {
//        self.init(frame: CGRectZero)
//        
//        self.delegate = delegate
//        if !hint.isEmpty {
//            self.hintText = hint
//        }
//        self.canCancel = canCancel
//    }

    override init(frame: CGRect) {
        let appFrame = UIApplication.sharedApplication().delegate?.window!!.frame
        super.init(frame: appFrame!)
        
        self.backgroundColor=UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.4)
        
        print("Function: \(#function) Line: \(#line)");
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    /// 设置Frame (已被屏蔽的方法) 调用无效 DEPRECATED_MSG_ATTRIBUTE("JFLoadBlockView did not support setFrame:, the default frame is fullscreen");
    override var frame: CGRect {
        didSet{
            
        }
    }
    
    deinit {
        delegate = nil
        print("Function: \(#function) Line: \(#line)");
    }
    
    // 类的internal方法(默认为此级别)
    //MARK:  - internal methods (default)
    func showInView(view:UIView!, connect:AnyObject?, text:String?, cancel:Bool) -> Void {
        self.connect = connect
        self.hintText = text!
        self.canCancel = cancel
        
        self.setupViewRootSubs(self)
        
        self.alpha = 0
        view.addSubview(self)
        
        //将控件缩小10倍
        self.contentView!.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: {
            self.alpha = 1
                self.contentView!.layer.setAffineTransform(CGAffineTransformMakeRotation(-45))
            }) { (finshed) in
                
                UIView.animateWithDuration(0.5, animations: {
                    self.contentView!.layer.setAffineTransform(CGAffineTransformIdentity)
                    }, completion: { (finished) in
                })
        }
    }
    
    func dismiss() -> Void {
        print("Function: \(#function) Line: \(#line)");
        self.removeFromSuperview()
    }
    
    // 所有的Actions
    //MARK:  - Actions
    func cancelBtnAction(sender:UIButton) {
        print("Function: \(#function) Line: \(#line)");
        
        self.dismiss()
        
        //关闭网络
        if (self.connect != nil) {
            
        }
        
        //请求代理
        self.delegate?.cancelLoadForContext?(context: self.connect)
    }
    
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
    private func setupViewRootSubs(parentView:UIView){
        let frame:CGRect = parentView.frame
        if (contentView == nil) {
            contentView = UIView(frame: CGRect(x: (Int(frame.width) - JFLoadBlockContentViewWidth) / 2, y: (Int(frame.height) - JFLoadBlockContentViewHeight) / 2, width: JFLoadBlockContentViewWidth, height: JFLoadBlockContentViewHeight));
            contentView?.backgroundColor = UIColor.whiteColor()
            contentView?.layer.masksToBounds = true
            contentView?.layer.cornerRadius = 5
        }
        
        self.setupViewContentSubs(contentView!)
        
        parentView.addSubview(contentView!)
    }
    
    private func setupViewContentSubs(parentView:UIView){
        let frame:CGRect = parentView.frame
        let btnWidth = 44, btnHeight = 44, btnSpace = 0
        
        // loding可以是图片动画或者第三方动画，暂时用系统lodign占位
        let activity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        activity.center = CGPoint(x: frame.width / 2, y: frame.height / 3)
        activity.activityIndicatorViewStyle = .Gray
        activity.startAnimating()
        parentView.addSubview(activity)
        
        if (canCancel && cancelBtn == nil) {
            cancelBtn = UIButton(type: .Custom)
            cancelBtn.frame = CGRect(x: Int(frame.width) - btnWidth - btnSpace, y: btnSpace, width: btnWidth, height: btnHeight)
            cancelBtn.setBackgroundImage(UIImage(named: "LoadingVCClose"), forState: .Normal)
            cancelBtn.setBackgroundImage(UIImage(named: "LoadingVCClosePress"), forState: .Highlighted)
            cancelBtn.addTarget(self, action: #selector(cancelBtnAction(_:)), forControlEvents: .TouchUpInside)
            
            parentView.addSubview(cancelBtn)
        }
        
        if (hintLabel == nil) {
            let hintRect = CGRect(x: 0, y: 2 * frame.height / 3, width: frame.width, height: frame.height / 3)
            hintLabel = UILabel(frame: hintRect)
            hintLabel!.textColor = UIColor.grayColor()
            hintLabel!.text = hintText
            hintLabel!.lineBreakMode = .ByWordWrapping
            hintLabel!.numberOfLines = 0
            hintLabel!.textAlignment = .Center
            hintLabel!.font = UIFont.systemFontOfSize(14)
            
            //计算使其文本垂直靠顶
            let options : NSStringDrawingOptions = .UsesLineFragmentOrigin
            let boundingRect = hintLabel?.text!.boundingRectWithSize(CGSizeMake(hintLabel!.frame.width, 0), options: options, attributes: [NSFontAttributeName:hintLabel!.font], context: nil)
            hintLabel!.frame = CGRect(origin: hintRect.origin, size: CGSize(width: hintRect.width, height: (boundingRect?.height)!))
            
            parentView.addSubview(hintLabel!)
        }
    }

}
