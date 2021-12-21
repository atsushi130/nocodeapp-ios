//
//  ImageTextCell.swift
//  nocodeapp-ios
//
//  Created by Atsushi Miyake on 2021/12/13.
//

import Foundation
import UIKit
import Extension

final class ImageTextCell: UICollectionViewCell, LayoutCell {

    private let stackView = UIStackView()
    private let imageContainerView = UIView()
    private let imageView = ImageView()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        self.layer.cornerRadius = 5
        self.configureContentView()
        self.configureStackView()
        self.configureImageView()
        self.configureTitleLabel()
    }

    private func configureContentView() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.shadowColor = UIColor.lightGray.cgColor
        self.contentView.layer.shadowOffset = .init(width: 0, height: 0.75)
        self.contentView.layer.shadowRadius = 2
        self.contentView.layer.shadowOpacity = 0.8
    }

    private func configureStackView() {
        self.stackView.distribution = .fill
        self.stackView.alignment = .leading
        self.stackView.axis = .vertical
        self.stackView.spacing = 8
        self.contentView.addSubview(self.stackView)
        self.stackView.fillSuperview(insets: .init(top: 5, left: 5, bottom: 8, right: 5))
    }

    private func configureImageView() {
        // containerView
        self.imageContainerView.backgroundColor = .white
        self.imageContainerView.clipsToBounds = true
        self.imageContainerView.layer.cornerRadius = 5
        self.imageContainerView.layer.shadowColor = UIColor.lightGray.cgColor
        self.imageContainerView.layer.shadowOffset = .init(width: 0, height: 2)
        self.imageContainerView.layer.shadowRadius = 10
        self.imageContainerView.layer.shadowOpacity = 0.5
        self.stackView.addArrangedSubview(self.imageContainerView)
        self.imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageContainerView.leftAnchor.constraint(equalTo: self.stackView.leftAnchor),
            self.imageContainerView.rightAnchor.constraint(equalTo: self.stackView.rightAnchor)
        ])
        // imageView
        self.imageView.layer.cornerRadius = 5
        self.imageView.contentMode = .scaleAspectFill
        self.imageContainerView.addSubview(self.imageView)
        self.imageView.fillSuperview()
        NSLayoutConstraint.activate([
            self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 1)
        ])
    }

    private func configureTitleLabel() {
        self.titleLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        self.titleLabel.textColor = .black
        self.titleLabel.numberOfLines = 1
        self.stackView.addArrangedSubview(self.titleLabel)
    }

    func apply(dataSource: LayoutDataSource) {
        self.titleLabel.text = dataSource.title
        self.imageView.imageURL = dataSource.imageURL
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.reset()
        self.titleLabel.text = nil
    }
}

