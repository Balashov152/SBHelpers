//
//  File.swift
//  SellFashion
//
//  Created by Sergey Balashov on 21.10.2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
//

import Foundation

public func range<E: Comparable>(min: E, element: E, max: E) -> E {
    return Swift.min(Swift.max(min, element), max)
}

