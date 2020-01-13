//
//  CollectionSectionItem.swift
//  SellFashion
//
//  Created by Sergey Balashov on 09.01.2020.
//  Copyright © 2020 Egor Otmakhov. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class CollectionSectionItem: IdentifiableType, Equatable, RowViewModel, RowViewModelActionble {
    static func == (lhs: CollectionSectionItem, rhs: CollectionSectionItem) -> Bool {
        return lhs.identity == rhs.identity
    }

    typealias Identity = Int
    var identity: Identity

    var cellType: RxCollectionViewCell.Type
    var action = PublishSubject<Void>()

    init<Value: Hashable>(identity: Value, cellType: RxCollectionViewCell.Type) {
        self.identity = identity.hashValue
        self.cellType = cellType
    }
}
