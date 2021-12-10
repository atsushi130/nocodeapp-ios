//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public struct NotionResponse<T: Object>: Decodable {
    public let object: String
    public let results: [T]
}

public protocol Object: Decodable {}
