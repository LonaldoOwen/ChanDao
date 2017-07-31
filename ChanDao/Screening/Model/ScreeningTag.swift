//
//  ScreeningTag.swift
//  ChanDao
//
//  Created by owen on 17/7/8.
//  Copyright © 2017年 owen. All rights reserved.
//

import Foundation

struct ScreeningTag {
    let id: String
    let name: String
    let subTags: [ScreeningTag]?
}

///
/*  */
enum ScreeningCase {
    case zero   // 选中0个，都未选中
    case one    // 选中1个
    case two    // 选中2个
    case three  // 选中3个
    case four   // 选择4个
}
