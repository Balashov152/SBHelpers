//
//  UILabel+Rx.swift
//  SellFashion
//
//  Created by Sergey Balashov on 28.11.2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
//

import RxCocoa
import RxKeyboard
import RxSwift

extension Reactive where Base: UILabel {
    public var textColor: Binder<UIColor> {
        Binder<UIColor>.init(base.self) { label, color in
            label.textColor = color
        }
    }
}
