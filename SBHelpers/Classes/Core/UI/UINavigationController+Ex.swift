//
//  UINavigationController+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 01/08/2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
//

import Foundation
import UIKit

public extension UINavigationController {
    func setTransparentBar(isHidden: Bool) {
        navigationBar.setBackgroundImage(isHidden ? UIImage() : nil, for: .default)
        navigationBar.shadowImage = isHidden ? UIImage() : nil
    }
}
