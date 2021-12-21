//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public extension Notion {
    struct TextData: Notion.Entity {
        let text: Text
        let annotations: Annotation
        let plainText: String
        let href: URL?
    }
}

public extension Notion.TextData {
    struct Text: Notion.Entity {
        let content: String
        let link: Link?
    }
}

public extension Notion.TextData.Text {
    struct Link: Notion.Entity {
        let url: URL?
    }
}
