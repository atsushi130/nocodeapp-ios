//
//  LayoutSection.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import UIKit
import Combine

extension Layout {
    final class LayoutSection: ComponentSection {

        var id: Section {
            return self.internalSection.id
        }

        private let repository: DataSourceRepository
        private let layout: Layout

        private(set) lazy var componentSection: ComponentSection = self

        private(set) lazy var layoutSection: NSCollectionLayoutSection = self.internalSection.layoutSection

        private(set) lazy var useCellTypes: [UICollectionViewCell.Type] = [ImageTextCell.self]

        private let internalSection: LayoutSectionProtocol

        init(layout: Layout, repository: DataSourceRepository = DataSourceRepository()) {
            self.layout = layout
            self.repository = repository
            guard let id = layout.id.plainText else {
                preconditionFailure("layout id not found.")
            }
            switch layout.type.layoutType {
            case .grid:
                self.internalSection = GridSection(id: id, numberOfColumns: layout.columns?.value ?? 1)
            case .scroll:
                self.internalSection = ScrollSection(id: id)
            default:
                preconditionFailure("layout type not supported.")
            }
        }

        func dequeueReuseableCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> LayoutCell? {
            return collectionView.dequeueReusableCell(ImageTextCell.self, for: indexPath)
        }

        func fetchDataSources() -> AnyPublisher<[LayoutDataSource], Never> {
            guard let url = self.layout.dataURL?.url else {
                return Just([]).eraseToAnyPublisher()
            }
            return self.repository.fetchDataSource(url: url, type: [LayoutDataSource].self)
                .replaceNil(with: [])
                .eraseToAnyPublisher()
        }
    }
}

protocol LayoutSectionProtocol {
    var id: Section { get }
    var layoutSection: NSCollectionLayoutSection { get }
}
