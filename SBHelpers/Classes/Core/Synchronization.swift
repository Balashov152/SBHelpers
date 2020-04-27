//
//  Synchronization.swift
//  SellFashion
//
//  Created by Sergey Balashov on 05.12.2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
//

import Foundation

public struct Synchronization {
    public static func sync<Item: Equatable>(item: Item, inCollection array: inout [Item], limit: Int) {
        if limit == 1 {
            array.removeAll()
            array.append(item)
        } else {
            if let index = array.firstIndex(where: { $0 == item }) {
                array.remove(at: index)
            } else {
                if limit == 0 {
                    array.append(item)
                } else if array.count < limit {
                    array.append(item)
                }
            }
        }
    }
}
