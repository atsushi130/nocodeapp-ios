//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public extension Notion {
    struct Number: TableData {
        public let id: String?
        public let type: String
        public let value: Int

        private enum CodingKeys: String, CodingKey {
            case id
            case type
            case value = "number"
        }
    }
}
