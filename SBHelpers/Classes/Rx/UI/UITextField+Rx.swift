//
//  UITextField+Rx.swift
//  SellFashion
//
//  Created by Sergey Balashov on 09.01.2020.
//  Copyright © 2020 Egor Otmakhov. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UITextField {
    func attributedPlaceholder(font: UIFont) -> Binder<String> {
        return Binder(base.self) { textField, placeholer in
            textField.attributedPlaceholder = NSAttributedString(string: placeholer, attributes: [.font: font])
        }
    }

    var placeholer: Binder<String?> {
        return Binder(base.self) { textField, placeholer in
            textField.placeholder = placeholer
        }
    }
}
