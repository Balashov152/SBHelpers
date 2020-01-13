//
//  DiffIterative.swift
//  SellFashion
//
//  Created by Sergey Balashov on 08/10/2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

public struct DiffIterative {
    public struct SequenceDiff<T1, T2> {
        public let common: [(T1, T2)]
        public let removed: [T1]
        public let inserted: [T2]
        public init(common: [(T1, T2)] = [], removed: [T1] = [], inserted: [T2] = []) {
            self.common = common
            self.removed = removed
            self.inserted = inserted
        }
    }

    public static func diffIterative<T1, T2: Equatable>(_ first: [T1], _ second: [T2], with compare: (T1, T2) -> Bool) -> SequenceDiff<T1, T2> {
        return diffIterativeBase(first, second, with: compare, with: ==)
    }

    public static func diffIterative<T1, T2: AnyObject>(_ first: [T1], _ second: [T2], with compare: (T1, T2) -> Bool) -> SequenceDiff<T1, T2> {
        return diffIterativeBase(first, second, with: compare, with: ===)
    }

    private static func diffIterativeBase<T1, T2>(_ first: [T1], _ second: [T2], with compare: (_ first: T1, _ second: T2) -> Bool, with compare2: (T2, T2) -> Bool) -> SequenceDiff<T1, T2> {
        if first.count == 0 {
            return SequenceDiff(inserted: second)
        }
        if second.count == 0 {
            return SequenceDiff(removed: first)
        }
        var common: [(T1, T2)] = []
        var removed: [T1] = []
        var inserted: [T2] = []
        var handledJ: [T2] = []
        outer: for index in first {
            for jndex in second {
                if compare(index, jndex) {
                    common.append((index, jndex))
                    handledJ.append(jndex)
                    continue outer
                }
            }
            removed.append(index)
        }
        for jndex in second {
            if handledJ.contains(where: { compare2($0, jndex) }) {
                continue
            }
            inserted.append(jndex)
        }
        return SequenceDiff(common: common, removed: removed, inserted: inserted)
    }
}
