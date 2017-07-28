//
//  Network.swift
//  Helper
//
//  Created by owen on 17/7/22.
//  Copyright © 2017年 owen. All rights reserved.
//

import Foundation

public class Network {
    
    // basic
    public static func request(method: String, url: String, headers: [String: String], parameters: [String: Any], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let manager = NetworkManager(url: url, method: method, headers: headers ,parameters: parameters, completionHandler: completionHandler)
        manager.run()
    }
    
    // 不带参数
    public static func request(method: String, url: String, headers: [String: String], completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let manager = NetworkManager(url: url, method: method, headers: headers, completionHandler: completionHandler)
        manager.run()
    }
    
    // GET 不带参数
    public static func get(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let manager = NetworkManager(url: url, method: "GET", completionHandler: completionHandler)
        manager.run()
    }
    
    // GET 带参数
    public static func get(url: String, headers: [String: String], parameters: [String: Any], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let manager = NetworkManager(url: url, method: "GET", headers: headers, parameters: parameters, completionHandler: completionHandler)
        manager.run()
    }
    
    // POST 不带参数
    public static func post(url: String, headers: [String: String], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let manager = NetworkManager(url: url, method: "POST", headers: headers, completionHandler: completionHandler)
        manager.run()
    }
    
    // POST 带参数
    public static func post(url: String, headers: [String: String], paremeters: [String: Any], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let manager = NetworkManager(url: url, method: "POST", headers: headers, parameters: paremeters, completionHandler: completionHandler)
        manager.run()
    }
}









