//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public struct Database<T>: Object where T: Table {
    public let id: String
    public let properties: T
}
