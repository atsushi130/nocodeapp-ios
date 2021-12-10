//
//  GridDataSource.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

struct LayoutDataSource: Decodable {
    let imageURL: URL
    let title: String

    private enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case title
    }
}
