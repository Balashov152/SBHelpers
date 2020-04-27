//
//  ErrorHandler.swift
//  SellFashion
//
//  Created by Sergey Balashov on 13.01.2020.
//  Copyright © 2020 Sellfashion. All rights reserved.
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

public extension PrimitiveSequence where Trait == SingleTrait {
    func catchError(_ handler: ErrorHandler, empty: Element) -> Observable<Element> {
        catchError { (error) -> Single<Element> in
            if ErrorHandlerConfig.handlerError.needHandlerError(error: error) {
                handler.error.onNext(error)
            }
            return .just(empty)
        }.asObservable()
    }

    func catchErrorNever(_ handler: ErrorHandler) -> Observable<Element> {
        catchError { (error) -> Single<Element> in
            if ErrorHandlerConfig.handlerError.needHandlerError(error: error) {
                handler.error.onNext(error)
            }
            return .never()
        }.asObservable()
    }

    func catchError(_ handler: ErrorHandler, empty: Element) -> Single<Element> {
        catchError { (error) -> Single<Element> in
            if ErrorHandlerConfig.handlerError.needHandlerError(error: error) {
                handler.error.onNext(error)
            }
            return .just(empty)
        }
    }

    func catchErrorNever(_ handler: ErrorHandler) -> Single<Element> {
        catchError { (error) -> Single<Element> in
            if ErrorHandlerConfig.handlerError.needHandlerError(error: error) {
                handler.error.onNext(error)
            }
            return .never()
        }
    }
}

public extension Observable {
    func catchErrorNever(_ handler: ErrorHandler) -> Observable<Element> {
        catchError { (error) -> Observable<Element> in
            if ErrorHandlerConfig.handlerError.needHandlerError(error: error) {
                handler.error.onNext(error)
            }
            return .never()
        }.asObservable()
    }

    func catchError(_ handler: ErrorHandler, empty: Element) -> Observable<Element> {
        catchError { (error) -> Observable<Element> in
            if ErrorHandlerConfig.handlerError.needHandlerError(error: error) {
                handler.error.onNext(error)
            }
            return .just(empty)
        }
    }
}
