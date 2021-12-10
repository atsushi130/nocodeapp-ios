//
//  Layout.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import NotionClient

struct Layout: Table {
    let type: Title
    let columns: Number?
    let text: RichText?
    let dataURL: NotionClient.URL?
    let index: Number

    private enum CodingKeys: String, CodingKey {
        case type
        case columns
        case text
        case dataURL = "dataUrl"
        case index
    }
}
