//
//  UISearchBar+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 09.01.2020.
//  Copyright © 2020 Egor Otmakhov. All rights reserved.
//

import UIKit

public extension UISearchBar {
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return searchTextField
        } else {
            return subviews.first?.subviews.first(where: { $0 is UITextField }) as? UITextField
        }
    }
}
