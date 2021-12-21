//
//  SectionBuilder.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation

final class SectionBuilder {
    func build(layout: Layout) -> ComponentSection? {
        switch layout.type.layoutType {
        case .title:
            return Layout.TitleSection(layout: layout)
        case .grid, .scroll:
            return Layout.LayoutSection(layout: layout)
        case .unknown:
            return nil
        }
    }
}
