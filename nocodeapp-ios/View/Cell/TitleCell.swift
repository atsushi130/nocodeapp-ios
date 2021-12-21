//
//  TitleCell.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/13.
//

import Foundation
import UIKit

final class TitleCell: UICollectionViewCell, LayoutCell {

    private let stackView = UIStackView()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        self.configureContentView()
        self.configureStackView()
        self.configureTitleLabel()
    }

    private func configureContentView() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.shadowColor = UIColor.lightGray.cgColor
        self.contentView.layer.shadowOffset = .init(width: 0, height: 2)
    }

    private func configureStackView() {
        self.stackView.distribution = .fill
        self.stackView.alignment = .leading
        self.stackView.axis = .vertical
        self.stackView.spacing = 2
        self.contentView.addSubview(self.stackView)
        self.stackView.fillSuperview(insets: .init(top: 10, left: 10, bottom: 10, right: 10))
    }

    private func configureTitleLabel() {
        self.titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        self.titleLabel.textColor = .black
        self.titleLabel.numberOfLines = 1
        self.stackView.addArrangedSubview(self.titleLabel)
    }

    func apply(dataSource: LayoutDataSource) {
        self.titleLabel.text = dataSource.title
    }
}
