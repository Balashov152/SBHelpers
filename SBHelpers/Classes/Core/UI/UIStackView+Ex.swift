//
//  UIStackView+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 02/09/2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import class UIKit.UIStackView

public extension UIStackView {
    func removeAll() {
        arrangedSubviews.forEach { removeArrangedSubview($0); $0.removeFromSuperview() }
    }
}
