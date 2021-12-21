//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/13.
//

import Foundation

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
