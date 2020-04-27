//
//  UITableView+Rx.swift
//  SellFashion
//
//  Created by Sergey Balashov on 04.04.2020.
//  Copyright © 2020 Egor Otmakhov. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension Reactive where Base: UITableView {
    var updateTable: Binder<Void> {
        Binder<Void>(base) { tableView, _ in
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}
