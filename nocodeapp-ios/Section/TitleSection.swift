//
//  TitleSection.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import UIKit
import Combine

extension Layout {
    final class TitleSection: ComponentSection {

        let id: Section

        private let layout: Layout

        private(set) lazy var componentSection: ComponentSection = self

        private(set) lazy var layoutSection: NSCollectionLayoutSection = {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .estimated(1))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .estimated(1))
            let padding: UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: padding.top,
                                                            leading: padding.left,
                                                            bottom: padding.bottom,
                                                            trailing: padding.right)
            return section
        }()

        private(set) lazy var useCellTypes: [UICollectionViewCell.Type] = [TitleCell.self]

        init(layout: Layout) {
            guard let id = layout.id.plainText else {
                preconditionFailure("layout id not found.")
            }
            self.id = .title(id: id)
            self.layout = layout
        }

        func dequeueReuseableCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> LayoutCell? {
            return collectionView.dequeueReusableCell(TitleCell.self, for: indexPath)
        }

        func fetchDataSources() -> AnyPublisher<[LayoutDataSource], Never> {
            if let title = self.layout.text?.plainText {
                let dataSource = LayoutDataSource(imageURL: nil, title: title)
                return Just([dataSource]).eraseToAnyPublisher()
            } else {
                return Just([]).eraseToAnyPublisher()
            }
        }
    }
}
