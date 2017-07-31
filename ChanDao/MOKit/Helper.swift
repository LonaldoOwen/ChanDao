//
//  Helper.swift
//  Helper
//
//  Created by owen on 17/7/22.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit

class Helper {

}

extension Helper {
    /// 读取plist返回数组
    /// @forResource plist名称
    /// @ofType plist类型
    /// @return [Any]
    public class func readPlist(forResource name: String?, ofType ext: String?) -> [Any]{
        
        let path = Bundle.main.path(forResource: name , ofType: ext)
        let fileManager = FileManager.default
        let plistData = fileManager.contents(atPath: path!)
        
        let tempArray: [[String: Any]] = try! PropertyListSerialization.propertyList(from: plistData!, options: [], format: nil) as! [[String : Any]]
        
        return tempArray
    }
}


