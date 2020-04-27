//
//  UIViewController+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 22/07/2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

extension UIViewController {
    public var errorAlert: Binder<Error?> {
        return Binder(self, scheduler: MainScheduler.asyncInstance, binding: { vc, error in
            guard var description = error?.localizedDescription else {
                vc.showErrorAlert(errorMessage: "no description")
                return
            }
            description = description.replacingOccurrences(of: "URLSessionTask failed with error: ", with: "")
            vc.showErrorAlert(errorMessage: description)
        })
    }

    public func showErrorAlert(title: String? = "Error", errorMessage: String?) {
        showOKAlert(title: title, message: errorMessage)
    }

    public func showOKAlert(title: String?, message: String?, okAction: @escaping () -> Void = {}) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ОK", style: .default, handler: { _ in
            okAction()
        }))
        present(alertController, animated: true)
    }

    public func showConfirmAlert(title: String?, message: String?,
                                 titleTrue: String? = "Yes", titleFalse: String? = "Cancel") -> Single<Bool> {
        
        Single<Bool>.create { [weak self] (event) -> Disposable in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: titleTrue, style: .destructive, handler: { _ in
                event(.success(true))
            }))
            alertController.addAction(UIAlertAction(title: titleFalse, style: .cancel, handler: { _ in
                event(.success(false))
            }))
            self?.present(alertController, animated: true)

            return Disposables.create {
                alertController.dismiss(animated: true)
            }
        }
    }
}
