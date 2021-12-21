//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public extension Notion {
    struct Title: TableData {
        public let id: String?
        public let type: String
        private let title: [TextData]

        public var plainText: String? {
            return self.title.first?.plainText
        }
    }
}
