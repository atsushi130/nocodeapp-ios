//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/13.
//

import Foundation
import UIKit

public extension UICollectionView {
    func register(cell: UICollectionViewCell.Type) {
        self.register(cell, forCellWithReuseIdentifier: String(describing: cell))
    }
    func dequeueReusableCell<T: UICollectionViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        self.dequeueReusableCell(withReuseIdentifier: String(describing: cell), for: indexPath) as! T
    }
}
