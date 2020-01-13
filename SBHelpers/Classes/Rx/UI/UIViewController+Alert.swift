//
//  UIViewController+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 22/07/2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

//TODO: Add localize for this file
extension UIViewController {
    public var errorAlert: Binder<Error?> {
        return Binder(self, scheduler: MainScheduler.asyncInstance, binding: { vc, error in
            vc.showErrorAlert(errorMessage: error?.localizedDescription)
        })
    }

    public func showErrorAlert(errorMessage: String?) {
        showOKAlert(title: "Ошибка", message: errorMessage)
    }

    public func showOKAlert(title: String?, message: String?, okAction: @escaping () -> Void = {}) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ОK", style: .default, handler: { _ in
            okAction()
        }))
        present(alertController, animated: true)
    }

    public func showConfirmAlert(title: String?, message: String?, yesAction _: @escaping () -> Void = {}) -> Single<Bool> {
        Single<Bool>.create { [weak self] (event) -> Disposable in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { _ in
                event(.success(true))
            }))
            alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in
                event(.success(false))
            }))
            self?.present(alertController, animated: true)

            return Disposables.create {
                alertController.dismiss(animated: true)
            }
        }
    }
}
