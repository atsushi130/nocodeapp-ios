//
//  Layout.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import NotionClient

struct Layout: Table, Equatable {
    let type: Notion.Title
    let id: Notion.RichText
    let columns: Notion.Number?
    let text: Notion.RichText?
    let dataURL: Notion.URL?
    let index: Notion.Number

    private enum CodingKeys: String, CodingKey {
        case type
        case id
        case columns
        case text
        case dataURL = "dataUrl"
        case index
    }
}

enum LayoutType: String {
    case title
    case grid
    case scroll
    case unknown
}

extension Notion.Title {
    var layoutType: LayoutType {
        switch self.plainText {
        case "title":
            return .title
        case "grid":
            return .grid
        case "scroll":
            return .scroll
        default:
            return .unknown
        }
    }
}
