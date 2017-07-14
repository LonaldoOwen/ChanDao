//
//  Network.swift
//  Network
//
//  Created by libowen on 2017/7/4.
//  Copyright © 2017年 libowen. All rights reserved.
//

import UIKit

class Network: NSObject {
    
    static func request(method: String, url: String, parameters: [String: Any], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let manager = NetworkManager(url: url, method: method, parameters: parameters, completionHandler: completionHandler)
        manager.run()
    }
}
