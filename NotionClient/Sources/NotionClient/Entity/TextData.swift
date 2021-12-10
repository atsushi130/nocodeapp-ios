//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public struct TextData: Decodable {
    let text: Text
    let annotations: Annotation
    let plainText: String
    let href: URL?
}

public extension TextData {
    struct Text: Decodable {
        let content: String
        let link: Link?
    }
}

public extension TextData.Text {
    struct Link: Decodable {
        let url: URL?
    }
}
