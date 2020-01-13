//
//  RxTableViewModel.swift
//  SellFashion
//
//  Created by Sergey Balashov on 06.11.2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

public protocol RxTableViewModeble: ErrorHandler, ActivityTracker {
    var sections: BehaviorRelay<[TableViewSection]> { get }
}

open class RxTableViewModel: RxViewModel, RxTableViewModeble {
    typealias Section = AnimatableSectionModel<String, TableSectionItem>
    var sections = BehaviorRelay<[Section]>(value: [])
}

public protocol RxSaveViewModelble: RxTableViewModel {
    var didTapSaveButton: PublishSubject<Void> { get set }
    var isEnableSaveButton: BehaviorRelay<Bool> { get set }
}

open class RxSaveViewModel: RxTableViewModel, RxSaveViewModelble {
    var didTapSaveButton = PublishSubject<Void>()
    var isEnableSaveButton = BehaviorRelay<Bool>(value: false)
}
