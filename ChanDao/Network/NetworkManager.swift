//
//  NetworkManager.swift
//  Network
//
//  Created by libowen on 2017/7/4.
//  Copyright © 2017年 libowen. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {

    let method: String!
    let url: String!
    let parameters: [String: Any]
    
    let session: URLSession = URLSession.shared
    var dataTask: URLSessionTask!
    var request: URLRequest!
    let completionHandler: (Data?, URLResponse?, Error?) -> Void
    
    init (url: String, method: String, parameters: [String: Any], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.completionHandler = completionHandler
        self.request = URLRequest(url: URL(string: self.url)!)
    }
    
    func buildRequest() {
        let header: [String: String] = ["Content-Type": "application/json", "seqnum": "0", "ver": "1.0", "uid": "498", "token": "nq4LWlvy7lJW-kh07fRRuDGeBwRvpnsJ0BGl17Xe4eeZEwvXwQN8HoBAluLmJbpQ", ]
        request.httpMethod = self.method
        request.allHTTPHeaderFields = header
    }
    
    func buildBody() {
        request.httpBody = try? JSONSerialization.data(withJSONObject: self.parameters, options: .prettyPrinted)
    }
    
    public func runTask() {
        dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            self.completionHandler(data, response, error)
        })
        dataTask.resume()
    }
    
    func run() {
        buildRequest()
        buildBody()
        runTask()
    }
}
