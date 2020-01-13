//
//  RxViewController.swift
//  SellFashion
//
//  Created by Sergey on 19/07/2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

open class RxViewControllerJ<ViewModel: RxViewModel>: RxViewController {
    public var viewModel: ViewModel!

    override open func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupNavigation()
    }

    override open func setupBindings() {
        super.setupBindings()
        viewModel.error
            .filter { [weak self] _ in self?.viewModel.showErrorAlert ?? false }
            .bind(to: errorAlert).disposed(by: disposeBag)
    }
}

open class RxViewController: UIViewController {
    public let disposeBag = DisposeBag()

    override open func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

    deinit {
        debugPrint("deinit", type(of: self))
    }

    open func setupBindings() {
        let mirror = Mirror(reflecting: self)
        if let vm = mirror.children.first(where: { $0.label == "viewModel" })?.value as? RxViewModel {
            vm.error.debug("error").bind(to: errorAlert).disposed(by: disposeBag)
        }
    }

    open func setupNavigation() {}
}
