//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public protocol Credential {
    func append(for headers: [String: String]) -> [String: String]
}

public struct KeyValueCredential: Credential {

    let key: String
    let value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }

    public func append(for headers: [String : String]) -> [String : String] {
        var headers = headers
        headers[self.key] = self.value
        return headers
    }
}
