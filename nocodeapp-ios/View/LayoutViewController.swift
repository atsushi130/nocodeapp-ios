//
//  LayoutViewController.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/10.
//

import Foundation
import UIKit
import Combine
import Extension

final class LayoutViewController: UIViewController {

    private var viewModel: LayoutViewModel!
    private var collectionView: UICollectionView?
    private var cancellable = Set<AnyCancellable>()

    private typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, LayoutDataSource>
    private var dataSource: DiffableDataSource?

    init() {
        self.viewModel = LayoutViewModel(repository: NotionRepository())
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.viewModel.$compositionalLayout
            .filterNil()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                guard let self = self, let collectionView = self.collectionView else { return }
                collectionView.removeFromSuperview()
            })
            .sink { [weak self] compositionalLayout in
                guard let self = self else { return }
                // CollectionView の設定
                let useCellTypes = self.viewModel.sections.flatMap { $0.useCellTypes }
                let collectionView = self.makeCollectionView(compositionalLayout: compositionalLayout, useCellTypes: useCellTypes)
                self.constraintCollectionView(collectionView)
                self.collectionView = collectionView
                // DiffableDataSource の設定
                self.dataSource = self.makeDiffableDataSource(collectionView: collectionView)
                // Section の設定
                let sections = self.viewModel.sections.map { $0.id }
                var snapshot = NSDiffableDataSourceSnapshot<Section, LayoutDataSource>()
                snapshot.appendSections(sections)
                self.dataSource?.apply(snapshot)
                self.viewModel.updateDataSource()
            }
            .store(in: &self.cancellable)

        self.viewModel.$sectionDataSource
            .filterNil()
            .receive(on: DispatchQueue.main)
            .compactMap { [weak self] sectionDataSource in
                guard let self = self, let dataSource = self.dataSource else { return nil }
                var snapshot = dataSource.snapshot()
                let itemIds = snapshot.itemIdentifiers(inSection: sectionDataSource.sectionId)
                snapshot.deleteItems(itemIds)
                snapshot.appendItems(sectionDataSource.dataSources, toSection: sectionDataSource.sectionId)
                return snapshot
            }
            .sink { [weak self] snapshot in
                self?.dataSource?.apply(snapshot, animatingDifferences: false, completion: nil)
            }
            .store(in: &self.cancellable)
    }

    func makeCollectionView(compositionalLayout: UICollectionViewCompositionalLayout, useCellTypes: [UICollectionViewCell.Type]) -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.backgroundColor = .white
        useCellTypes.forEach(collectionView.register(cell:))
        return collectionView
    }

    private func makeDiffableDataSource(collectionView: UICollectionView) -> DiffableDataSource {
        return DiffableDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item -> UICollectionViewCell? in
            guard let self = self,
                  let section = self.viewModel.sections[safe: indexPath.section],
                  let cell = section.dequeueReuseableCell(collectionView, at: indexPath) else { return nil }
            cell.apply(dataSource: item)
            return cell
        }
    }

    func constraintCollectionView(_ collectionView: UICollectionView) {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.updateLayouts()
            .sink { _ in }
            .store(in: &self.cancellable)
        self.viewModel.monitoring()
    }
}
