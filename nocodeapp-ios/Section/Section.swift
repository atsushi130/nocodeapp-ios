//
//  Section.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import UIKit
import Combine

protocol ComponentSection: AnyObject {
    var id: Section { get }
    var componentSection: ComponentSection { get }
    var layoutSection: NSCollectionLayoutSection { get }
    var useCellTypes: [UICollectionViewCell.Type] { get }
    func dequeueReuseableCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell?
}

protocol DataSourceComponentSection: ComponentSection {
    func fetchDataSource() -> AnyPublisher<[LayoutDataSource], Never>
}

enum Section: Hashable, Equatable {
    case title(id: String)
    case grid(id: String)
    case scroll(id: String)
}
