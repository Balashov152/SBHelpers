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
    public typealias Section = AnimatableSectionModel<String, TableSectionItem>
    public var sections = BehaviorRelay<[Section]>(value: [])
}

public protocol RxSaveViewModelble: RxTableViewModel {
    var didTapSaveButton: PublishSubject<Void> { get set }
    var isEnableSaveButton: BehaviorRelay<Bool> { get set }
}

open class RxSaveViewModel: RxTableViewModel, RxSaveViewModelble {
    public var didTapSaveButton = PublishSubject<Void>()
    public var isEnableSaveButton = BehaviorRelay<Bool>(value: false)
}
