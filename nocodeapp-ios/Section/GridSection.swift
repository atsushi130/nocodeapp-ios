//
//  GridSection.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import UIKit

extension Layout {
    final class GridSection: LayoutSectionProtocol {

        let id: Section
        let appearance: Appearance

        private(set) lazy var layoutSection: NSCollectionLayoutSection = {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .estimated(1))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .estimated(1))
            let padding = self.appearance.padding
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: self.appearance.numberOfColumns)
            group.interItemSpacing = .fixed(self.appearance.spacing.x)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = self.appearance.spacing.y
            section.contentInsets = NSDirectionalEdgeInsets(top: padding.top,
                                                            leading: padding.left,
                                                            bottom: padding.bottom,
                                                            trailing: padding.right)
            return section
        }()

        init(id: String, numberOfColumns: Int) {
            self.id = .grid(id: id)
            self.appearance = Appearance(numberOfColumns: numberOfColumns)
        }
    }
}

extension Layout.GridSection {
    struct Appearance {
        let padding: UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        let spacing: CGPoint = .init(x: 8, y: 8)
        let numberOfColumns: Int
        init(numberOfColumns: Int) {
            self.numberOfColumns = numberOfColumns
        }
    }
}
