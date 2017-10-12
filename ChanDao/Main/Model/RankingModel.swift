//
//  File.swift
//  ChanDao
//
//  Created by libowen on 2017/7/14.
//  Copyright © 2017年 owen. All rights reserved.
//

import Foundation

struct RankingModel {
    let index: String
    let name: String
    let totalCount: String
    
    init(index: String = "0", name: String, totalCount:String) {
        self.index = index
        self.name = name
        self.totalCount = totalCount
    }
}
