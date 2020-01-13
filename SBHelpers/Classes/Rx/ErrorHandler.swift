//
//  ErrorHandler.swift
//  SellFashion
//
//  Created by Sergey Balashov on 13.01.2020.
//  Copyright © 2020 Egor Otmakhov. All rights reserved.
//

import RxCocoa
import RxSwift

public protocol ErrorHandler {
    var showErrorAlert: Bool { get }
    var error: PublishSubject<Error> { get }
}

open class ErrorHandlerConfig {
    public static var handlerError = HandlerError()
}

open class HandlerError {
    func needHandlerError(error _: Error) -> Bool {
        return true
    }
}

public extension PrimitiveSequence where TraitType == SingleTrait {
    func catchError(_ handler: ErrorHandler, empty: Element) -> Observable<E> {
        catchError { (error) -> Single<E> in
            if ErrorHandlerConfig.handlerError.needHandlerError(error: error) {
                handler.error.onNext(error)
            }
            return .just(empty)
        }.asObservable()
    }

    func catchErrorNever(_ handler: ErrorHandler) -> Observable<E> {
        catchError { (error) -> Single<E> in
            if ErrorHandlerConfig.handlerError.needHandlerError(error: error) {
                handler.error.onNext(error)
            }
            return .never()
        }.asObservable()
    }

    func catchError(_ handler: ErrorHandler, empty: Element) -> Single<E> {
        catchError { (error) -> Single<E> in
            if ErrorHandlerConfig.handlerError.needHandlerError(error: error) {
                handler.error.onNext(error)
            }
            return .just(empty)
        }
    }

    func catchErrorNever(_ handler: ErrorHandler) -> Single<E> {
        catchError { (error) -> Single<E> in
            if ErrorHandlerConfig.handlerError.needHandlerError(error: error) {
                handler.error.onNext(error)
            }
            return .never()
        }
    }
}

public extension Observable {
    func catchErrorNever(_ handler: ErrorHandler) -> Observable<E> {
        catchError { (error) -> Observable<E> in
            if ErrorHandlerConfig.handlerError.needHandlerError(error: error) {
                handler.error.onNext(error)
            }
            return .never()
        }.asObservable()
    }

    func catchError(_ handler: ErrorHandler, empty: Element) -> Observable<E> {
        catchError { (error) -> Observable<E> in
            if ErrorHandlerConfig.handlerError.needHandlerError(error: error) {
                handler.error.onNext(error)
            }
            return .just(empty)
        }
    }
}
