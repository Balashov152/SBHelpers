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

open class CollectionSectionItem: IdentifiableType, Equatable, RowViewModel, RowViewModelActionble {
    public static func == (lhs: CollectionSectionItem, rhs: CollectionSectionItem) -> Bool {
        return lhs.identity == rhs.identity
    }

    public typealias Identity = Int
    public var identity: Identity

    public var cellType: RxCollectionViewCell.Type
    public var action = PublishSubject<Void>()

    init<Value: Hashable>(identity: Value, cellType: RxCollectionViewCell.Type) {
        self.identity = identity.hashValue
        self.cellType = cellType
    }
}
