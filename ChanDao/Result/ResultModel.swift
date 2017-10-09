//
//  ResultModel.swift
//  ChanDao
//
//  Created by libowen on 2017/8/23.
//  Copyright © 2017年 owen. All rights reserved.
//

import Foundation

struct ResultModel {
    
    let developer: String?
    let product: String?
    let productName: String?
    let project: String?
    let projectName: String?
    let level: String?
    let totalCount: String?
    
    init(developer: String, product: String, productName: String, project: String, projectName: String, level: String, totalCount: String) {
        self.developer = developer
        self.product = product
        self.productName = productName
        self.project = project
        self.projectName = projectName
        self.level = level
        self.totalCount = totalCount
    }
}
