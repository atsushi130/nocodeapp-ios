//
//  LayoutViewModel.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import UIKit
import Combine
import Extension

final class LayoutViewModel {

    @Published private(set) var compositionalLayout: UICollectionViewCompositionalLayout?
    @Published private var layouts: [Layout] = []
    @Published private(set) var sections: [ComponentSection] = []
    @Published private(set) var sectionDataSource: SectionDataSource?

    private let repository: NotionRepository
    private var monitor: Timer.TimerPublisher?

    private var cancellable = Set<AnyCancellable>()
    private var monitorCancellable: AnyCancellable?

    init(repository: NotionRepository) {
        self.repository = repository

        self.$layouts
            .dropFirst()
            .map { layouts in
                return layouts.compactMap { layout in
                    layout.section
                }
            }
            .assign(to: \.sections, on: self)
            .store(in: &self.cancellable)

        self.$sections
            .dropFirst()
            .map { sections in
                return sections.map { section in
                    section.layoutSection
                }
            }
            .map { layoutSections in
                return UICollectionViewCompositionalLayout { (sectionIndex: Int, _) in
                    return layoutSections[sectionIndex]
                }
            }
            .assign(to: \.compositionalLayout, on: self)
            .store(in: &self.cancellable)
    }

    func updateLayouts() -> AnyPublisher<[Layout]?, Never> {
        return self.repository.fetchLayouts()
            .map { [weak self] layouts in
                guard let self = self else { return nil }
                if let layouts = layouts {
                    // 差分がある場合のみ更新する
                    if self.layouts != layouts {
                        self.layouts = layouts
                    }
                }
                return layouts
            }
            .eraseToAnyPublisher()
    }

    func updateDataSource() {
        self.sections
            .forEach { section in
                // データソース並列取得
                section.fetchDataSources()
                    .map { dataSources in
                        return SectionDataSource(sectionId: section.id, dataSources: dataSources)
                    }
                    .assign(to: \.sectionDataSource, on: self)
                    .store(in: &self.cancellable)
            }
    }

    func monitoring() {
        if let _ = self.monitor, let monitorCancellable = self.monitorCancellable {
            monitorCancellable.cancel()
            self.monitor = nil
        }
        let monitor = Timer.publish(every: 2, on: .main, in: .common)
        self.monitorCancellable = monitor
            .autoconnect()
            .flatMap { [weak self] _ -> AnyPublisher<[Layout]?, Never> in
                guard let self = self else {
                    return Empty().eraseToAnyPublisher()
                }
                return self.updateLayouts()
            }
            .sink { _ in }
        self.monitor = monitor
    }
}

struct SectionDataSource {
    let sectionId: Section
    let dataSources: [LayoutDataSource]
}
