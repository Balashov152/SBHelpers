//
//  UIButton+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 21.10.2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIButton {
    public var isSelectedChanged: ControlProperty<Bool> {
        return base.rx.controlProperty(
            editingEvents: [.allEditingEvents, .valueChanged],
            getter: { $0.isSelected },
            setter: { $0.isSelected = $1 }
        )
    }

    public var nonAnimationTitle: Binder<String?> {
        return Binder<String?>(base, binding: { button, title in
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    button.setTitle(title, for: .normal)
                    button.layoutIfNeeded()
                }
            }
        })
    }
}
