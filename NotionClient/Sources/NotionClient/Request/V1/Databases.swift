//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import Gateway

public extension Version1 {
    enum Databases {}
}

public extension Version1.Databases {

    // Document: https://developers.notion.com/reference/post-database-query
    struct Query: NotionRequest {

        private let databaseId: String

        public init(databaseId: String) {
            self.databaseId = databaseId
        }

        public var path: String {
            return "/v1/databases/\(self.databaseId)/query"
        }

        public var method: Gateway.Method {
            return .post
        }

        public var body: [String : Any]? {
            return [
                "sorts": [
                    [
                        "property": "index",
                        "direction": "ascending"
                    ]
                ]
            ]
        }
    }
}
