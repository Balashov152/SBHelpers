//
//  Recursive.swift
//  SellFashion
//
//  Created by Sergey Balashov on 30.10.2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import Foundation
import RxSwift

public struct Recursive {
    public static var deadlineDispose = 0.5

    static public func recursive<Element>(elements: [Element],
                                   method: @escaping ((Element) -> Single<Void>),
                                   error: @escaping ((Error) -> Single<Void>) = { _ in Single<Void>.just(()) }) -> Single<Void> {
        guard !elements.isEmpty, let first = elements.first else {
            return Single<Void>.just(())
        }

        return Single<Element>.just(first).flatMap { (element) -> Single<Void> in
            method(element).catchError(error)
                .flatMap {
                    Recursive.recursive(elements: elements.tail, method: method, error: error) // retry call
            }
        }
    }

    static public func recursiveOnDispose<Element>(elements: [Element],
                                            method: @escaping ((Element) -> Single<Void>),
                                            error: @escaping ((Error) -> Single<Void>) = { _ in Single<Void>.just(()) }) -> Single<Void> {
        guard !elements.isEmpty, let first = elements.first else {
            return Single<Void>.just(())
        }

        return Single<Void>.create { (single) -> Disposable in
            var recursiveOnDispose: Disposable?
            let method = method(first).asObservable().do(onDispose: {
                DispatchQueue.main.asyncAfter(deadline: .now() + Recursive.deadlineDispose) {
                    recursiveOnDispose = Recursive.recursiveOnDispose(elements: elements.tail, method: method, error: error).subscribe(single)
                }
            }).subscribe()

            return Disposables.create {
                method.dispose()
                recursiveOnDispose?.dispose()
            }
        }
    }
}

extension Array {
    var tail: Array { Array(dropFirst()) }
}
