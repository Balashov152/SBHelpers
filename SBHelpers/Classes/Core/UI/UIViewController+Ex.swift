//
//  UIViewController+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 09.01.2020.
//  Copyright © 2020 Sellfashion. All rights reserved.
//

import UIKit

public extension UIViewController {
    /// load controller from nib, search Nib file for class name
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: T.self), bundle: Bundle(for: T.self))
        }

        return instantiateFromNib()
    }
}
