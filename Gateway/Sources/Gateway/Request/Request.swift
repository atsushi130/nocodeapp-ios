//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public protocol Request {
    var baseURLString: String { get }
    var path: String { get }
    var method: Method { get }
    var urlRequest: URLRequest? { get }
    var headers: [String: String] { get }
    var body: [String: Any]? { get }
    var timeoutInterval: TimeInterval { get }
    var cachePolicy: NSURLRequest.CachePolicy { get }
}

public extension Request {

    // var baseURLString: String {
    //     return "https://api.notion.com"
    // }

    var url: URL? {
        return URL(string: "\(self.baseURLString)\(self.path)")
    }

    // var headers: [String: String] {
    //     return [
    //         "Content-Type": "application/json",
    //         "Notion-Version": "2021-05-13"
    //     ]
    // }

    var timeoutInterval: TimeInterval {
        return 30
    }

    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringCacheData
    }

    var urlRequest: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url, cachePolicy: self.cachePolicy, timeoutInterval: self.timeoutInterval)
        request.httpMethod = self.method.rawValue
        if let body = self.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        request.allHTTPHeaderFields = self.headers
        return request
    }
}
