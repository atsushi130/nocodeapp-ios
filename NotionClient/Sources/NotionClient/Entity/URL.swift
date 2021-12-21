//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public extension Notion {
    struct URL: TableData {
        public let id: String?
        public let type: String
        public let url: Foundation.URL
    }
}
