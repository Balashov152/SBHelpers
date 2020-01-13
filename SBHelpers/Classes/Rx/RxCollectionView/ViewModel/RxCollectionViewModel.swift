//
//  RxSaveCollectionViewModel.swift
//  SellFashion
//
//  Created by Sergey Balashov on 09.01.2020.
//  Copyright © 2020 Egor Otmakhov. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift

protocol RxCollectionViewModeble: ErrorHandler, ActivityTracker {
    associatedtype TypeSection: IdentifiableType
    typealias Section = AnimatableSectionModel<TypeSection, CollectionSectionItem>
    var sections: BehaviorRelay<[Section]> { get }
}

class RxCollectionViewModel: RxViewModel, RxCollectionViewModeble {
    typealias TypeSection = String
    var sections = BehaviorRelay<[Section]>(value: [])
}

protocol RxSaveCollectionViewModelble: RxCollectionViewModel {
    var didTapSaveButton: PublishSubject<Void> { get set }
    var isEnableSaveButton: BehaviorRelay<Bool> { get set }
}

class RxSaveCollectionViewModel: RxCollectionViewModel, RxSaveCollectionViewModelble {
    var didTapSaveButton = PublishSubject<Void>()
    var isEnableSaveButton = BehaviorRelay<Bool>(value: false)
}
