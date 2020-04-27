//
//  RowViewModelActionble.swift
//  SellFashion
//
//  Created by Sergey Balashov on 27.04.2020.
//  Copyright © 2020 Egor Otmakhov. All rights reserved.
//

import Foundation
import RxSwift

public protocol RowViewModelActionble {
    var action: PublishSubject<Void> { get set }
}

public extension ObservableType where Element: RowViewModelActionble {
    func action() -> Disposable {
        return subscribe(onNext: { $0.action.onNext(()) })
    }
}
