//
//  File.swift
//  
//
//  Created by Atsushi Miyake on 2021/12/13.
//

import Foundation
import UIKit

public extension UIView {

    func fillSuperview(insets: UIEdgeInsets) {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -insets.right)
        ])
    }

    func fillSuperview() {
        self.fillSuperview(insets: .zero)
    }
}
