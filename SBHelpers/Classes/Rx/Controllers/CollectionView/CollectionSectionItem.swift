//
//  CollectionSectionItem.swift
//  SellFashion
//
//  Created by Sergey Balashov on 09.01.2020.
//  Copyright © 2020 Sellfashion. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

open class CollectionSectionItem: NSObject, IdentifiableType, RowViewModel, RowViewModelActionble {
    open override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? CollectionSectionItem else {
            return false
        }
        return identity == object.identity
    }

    public typealias Identity = String
    public var identity: Identity

    public var cellType: RxCollectionViewCell.Type
    public var action = PublishSubject<Void>()

    public init<Value: StringConvertible>(identity: Value, cellType: RxCollectionViewCell.Type) {
        self.identity = identity.string
        self.cellType = cellType
    }
}

public extension Reactive where Base: UICollectionView {
    func actionModelSelected<Model: RowViewModelActionble>(_ type: Model.Type) -> Disposable {
        return base.rx.modelSelected(type).action()
    }
}
