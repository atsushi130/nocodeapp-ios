//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

public protocol TableData: Decodable {
    var id: String? { get }
    var type: String { get }
}
