//
//  Collection+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 05.12.2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import protocol Swift.Collection

public extension Collection where Element: Equatable {
    func contains(oneOfCollection: [Element]) -> Bool {
        contains(where: { oneOfCollection.contains($0) })
    }
}

public extension Array {
    func safeElement(index: Int) -> Element? {
        if indices.contains(index) {
            return self[index]
        }
        return nil
    }
}

public extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            } else {
                print("Dublicate item: ", item)
            }
        }
        return uniqueValues
    }
}
