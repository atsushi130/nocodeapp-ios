//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public extension Notion {
    struct RichText: TableData {
        public let id: String?
        public let type: String
        private let richText: [TextData]

        public var plainText: String? {
            return self.richText.first?.plainText
        }
    }
}
