//
//  NetworkManager.swift
//  Helper
//
//  Created by owen on 17/7/22.
//  Copyright © 2017年 owen. All rights reserved.
//

import Foundation


class NetworkManager {
    
    let method: String!
    let url: String!
    let parameters: [String: Any]
    let headers: [String: String]
    
    let session: URLSession = URLSession.shared
    var dataTask: URLSessionTask!
    var request: URLRequest!
    let completionHandler: (Data?, URLResponse?, Error?) -> Void
    
    /**
     @parameters: 默认为空
     */
    init (url: String, method: String, headers: [String: String] = [:], parameters: [String: Any] = [:], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.url = url
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.completionHandler = completionHandler
        self.request = URLRequest(url: URL(string: self.url)!)
    }
    
    func buildRequest() {
        if self.method == "GET" && self.parameters.count > 0 {
            self.request = URLRequest(url: URL(string: url + "?" + buildParams(parameters: parameters as [String : Any]))!)
        }
        request.httpMethod = self.method
        /*关于httpHeader还可以再优化的*/
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        print("request.headers: \(request.allHTTPHeaderFields)")
    }
    
    func buildBody() {
        if self.parameters.count > 0 && self.method != "GET" {
            // Content-Type = application/json
            request.httpBody = try? JSONSerialization.data(withJSONObject: self.parameters, options: .prettyPrinted)
            //request.httpBody = buildParams(parameters: parameters).data(using: .utf8, allowLossyConversion: false)
        }
        print("request.httpBody: \(request.httpBody)")
    }
    
    func runTask() {
        dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            self.completionHandler(data, response, error)
        })
        dataTask.resume()
    }
    
    public func run() {
        buildRequest()
        buildBody()
        runTask()
    }
    
    
    /// helper
    
    // 这三个方法是URl ecoding，Content-Type＝application/x-www-form-urlencoded
    // 从 Alamofire 偷了三个函数
    func buildParams(parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += self.queryComponents(fromKey: key, value: value)
        }
        let joinedString = (components.map{"\($0)=\($1)"}).joined(separator: "&")
        return joinedString
    }
    
    /// Creates percent-escaped, URL encoded query string components from the given key-value pair using recursion.
    ///
    /// - parameter key:   The key of the query component.
    /// - parameter value: The value of the query component.
    ///
    /// - returns: The percent-escaped, URL encoded query string components.
    public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: "\(key)[]", value: value)
            }
        } else if let value = value as? NSNumber {
            if value.isBool {
                components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
            } else {
                components.append((escape(key), escape("\(value)")))
            }
        } else if let bool = value as? Bool {
            components.append((escape(key), escape((bool ? "1" : "0"))))
        } else {
            // value为String的走到这里
            components.append((escape(key), escape("\(value)")))
        }
        
        return components
    }
    
    /// Returns a percent-escaped string following RFC 3986 for a query string key or value.
    ///
    /// RFC 3986 states that the following characters are "reserved" characters.
    ///
    /// - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
    /// - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
    ///
    /// In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
    /// query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
    /// should be percent-escaped in the query string.
    ///
    /// - parameter string: The string to be percent-escaped.
    ///
    /// - returns: The percent-escaped string.
    public func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        var escaped = ""
        
        //==========================================================================================================
        //
        //  Batching is required for escaping due to an internal bug in iOS 8.1 and 8.2. Encoding more than a few
        //  hundred Chinese characters causes various malloc error crashes. To avoid this issue until iOS 8 is no
        //  longer supported, batching MUST be used for encoding. This introduces roughly a 20% overhead. For more
        //  info, please refer to:
        //
        //      - https://github.com/Alamofire/Alamofire/issues/206
        //
        //==========================================================================================================
        if #available(iOS 8.3, *) {
            escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
        } else {
            let batchSize = 50
            var index = string.startIndex
            
            while index != string.endIndex {
                let startIndex = index
                let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
                let range = startIndex..<endIndex
                
                let substring = string.substring(with: range)
                
                escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? substring
                
                index = endIndex
            }
        }
        
        return escaped
    }
    
}

extension NSNumber {
    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}
