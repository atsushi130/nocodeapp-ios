//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public extension Notion {
    struct Annotation: Entity {
        let bold: Bool
        let italic: Bool
        let strikethrough: Bool
        let underline: Bool
        let code: Bool
        let color: String
    }
}
