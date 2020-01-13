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

class TableSectionItem: IdentifiableType, Equatable, RowViewModel, RowViewModelActionble {
    static func == (lhs: TableSectionItem, rhs: TableSectionItem) -> Bool {
        return lhs.identity == rhs.identity
    }

    typealias Identity = Int
    var identity: Identity

    var cellType: RxTableViewCell.Type
    var action = PublishSubject<Void>()

    init<Value: Hashable>(identity: Value, cellType: RxTableViewCell.Type) {
        self.identity = identity.hashValue
        self.cellType = cellType
    }
}

protocol RowViewModelActionble {
    var action: PublishSubject<Void> { get set }
}

extension Reactive where Base: UITableView {
    func actionModelSelected<Model: RowViewModelActionble>(_ type: Model.Type) -> Disposable {
        return base.rx.modelSelected(type).action()
    }
}

extension ObservableType where E: RowViewModelActionble {
    func action() -> Disposable {
        return subscribe(onNext: { $0.action.onNext(()) })
    }
}
