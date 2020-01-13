//
//  RxViewModel.swift
//  SellFashion
//
//  Created by Sergey Balashov on 23/07/2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import RxViewController

open class RxViewModel: ActivityTracker, ErrorHandler {
    let disposeBag = DisposeBag()
    public let activityIndicator = ActivityIndicator()

    let error = PublishSubject<Error>()
    var showErrorAlert = true

    open func commonInit() {
        setupBindings()
    }

    open func setupBindings() {}

    init(viewController: UIViewController) {
        debugPrint("init with ViewController", type(of: self))
        viewController.rx.viewDidLoad.subscribe(onNext: { [weak self] in
            self?.commonInit()
        }).disposed(by: disposeBag)
    }

    public init() {
        debugPrint("init", type(of: self))
        commonInit()
    }

    deinit {
        debugPrint("deinit", type(of: self))
    }
}
