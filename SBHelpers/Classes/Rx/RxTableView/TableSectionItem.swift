//
//  TableSectionItem.swift
//  SellFashion
//
//  Created by Sergey Balashov on 09.01.2020.
//  Copyright © 2020 Egor Otmakhov. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

open class TableSectionItem: IdentifiableType, Equatable, RowViewModel, RowViewModelActionble {
    public static func == (lhs: TableSectionItem, rhs: TableSectionItem) -> Bool {
        return lhs.identity == rhs.identity
    }

    public typealias Identity = Int
    public var identity: Identity

    open var cellType: RxTableViewCell.Type
    open var action = PublishSubject<Void>()

    public init<Value: Hashable>(identity: Value, cellType: RxTableViewCell.Type) {
        self.identity = identity.hashValue
        self.cellType = cellType
    }
}

public protocol RowViewModelActionble {
    var action: PublishSubject<Void> { get set }
}

public extension Reactive where Base: UITableView {
    func actionModelSelected<Model: RowViewModelActionble>(_ type: Model.Type) -> Disposable {
        return base.rx.modelSelected(type).action()
    }
}

public extension ObservableType where E: RowViewModelActionble {
    func action() -> Disposable {
        return subscribe(onNext: { $0.action.onNext(()) })
    }
}
