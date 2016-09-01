//
//  JFUtilDef.swift
//  JFUIKit
//
//  Created by qitmac000260 on 16/9/1.
//  Copyright © 2016年 jinfeng.du. All rights reserved.
//

import UIKit

/**
 版本检查 大于此版本号
 
 - parameter version: 用于比较的版本号
 
 - returns: 比较结果Bool
 */
func IS_ASCENDING_IOS_VERSION(version:String) -> Bool {
    
    let result = UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch)
    if (result == .OrderedDescending) {
        return true
    }
    
    return false
}

/**
 检查版本 小于此版本号
 
 - parameter version: 用于比较的版本号
 
 - returns: 比较结果Bool
 */
func IS_DESCENDING_IOS_VERSION(version:String) -> Bool {
    
    let result = UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch)
    if (result == .OrderedAscending) {
        return true
    }
    
    return false
}