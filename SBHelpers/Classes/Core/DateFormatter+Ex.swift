//
//  DateFormatter+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 07/10/2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
//

import Foundation
public extension DateFormatter {
    convenience init(format: String) {
        self.init()
        dateFormat = format
    }
}
