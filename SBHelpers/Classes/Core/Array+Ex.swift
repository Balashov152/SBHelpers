//
//  Collection+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 05.12.2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
//

import protocol Swift.Collection

public extension Collection where Element: Equatable {
    func contains(oneOfCollection: [Element]) -> Bool {
        contains(where: { oneOfCollection.contains($0) })
    }
}

public extension Array {
    subscript(safe index: Int) -> Element? {
        if indices.contains(index) {
            return self[index]
        }
        return nil
    }

    mutating func safeInsert(_ newElement: Element, at index: Int) {
        if indices.contains(index) {
            insert(newElement, at: index)
        }
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

public extension Array where Element: Hashable {
    var unique: [Element] {
        NSOrderedSet(array: self).array as? [Element] ?? []
    }
}
