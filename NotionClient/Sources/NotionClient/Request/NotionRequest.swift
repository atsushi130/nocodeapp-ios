//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import Gateway

public protocol NotionRequest: Request {}

public extension NotionRequest {

    var baseURLString: String {
        return "https://api.notion.com"
    }

    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "Notion-Version": "2021-05-13"
        ]
    }
}
