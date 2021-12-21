//
//  ScrollSection.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import UIKit

extension Layout {
    final class ScrollSection: LayoutSectionProtocol {

        let id: Section
        let appearance = Appearance()

        private(set) lazy var layoutSection: NSCollectionLayoutSection = {
            let padding = self.appearance.padding
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(self.appearance.widthAspect),
                                                  heightDimension: .estimated(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(self.appearance.widthAspect),
                                                   heightDimension: .estimated(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            group.interItemSpacing = .fixed(self.appearance.spacing.x)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: padding.top,
                                                            leading: padding.left,
                                                            bottom: padding.bottom,
                                                            trailing: padding.right)
            section.interGroupSpacing = self.appearance.spacing.x
            section.orthogonalScrollingBehavior = .continuous
            return section
        }()

        init(id: String) {
            self.id = .scroll(id: id)
        }
    }
}

extension Layout.ScrollSection {
    struct Appearance {
        let padding: UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        let widthAspect: CGFloat = 0.4
        let spacing: CGPoint = .init(x: 8, y: 0)
    }
}
