//
//  LayoutCell.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/13.
//

import Foundation
import UIKit

protocol LayoutCell: UICollectionViewCell {
    func apply(dataSource: LayoutDataSource)
}
