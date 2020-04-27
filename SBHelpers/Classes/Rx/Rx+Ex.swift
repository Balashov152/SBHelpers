//
//  Rx+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 05.11.2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
//

import RxCocoa
import RxSwift

public extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        return map { _ in Void() }
    }

    func map<A: AnyObject, R>(weak obj: A, selector: @escaping (A) throws -> R) -> Observable<R> {
        return flatMap { [weak obj] (_) -> Observable<R> in
            obj.map { obj in
                self.map { _ in try selector(obj) }
            } ?? .empty()
        }
    }

    func weakMap<A: AnyObject, R>(weak obj: A, method: @escaping (A) -> (Self.Element) -> R) -> Observable<R> {
        return flatMap { [weak obj] (value) -> Observable<R> in
            guard let obj = obj else { return .empty() }
            return .just(method(obj)(value))
        }
    }
}

public extension PrimitiveSequence where Trait == SingleTrait {
    func mapToVoid() -> Single<Void> {
        return map { _ in Void() }
    }
}

public extension SharedSequence {
    func unwrap<T>() -> SharedSequence<SharingStrategy, T> where Element == T? {
        return filter { $0 != nil }.map { $0! }
    }
}

public extension ObservableType {
    func unwrap<T>() -> Observable<T> where Element == T? {
        return filter { $0 != nil }.map { $0! }
    }
}

public extension ObservableType {
    func bindValue<T>(to: BehaviorRelay<T?>,
                      predicate: ((T?, Element) -> Bool)? = nil,
                      update: @escaping (inout T?, Element) -> Void) -> Disposable {
        subscribe(onNext: { [weak to] value in
            var model = to?.value
            if predicate?(model, value) ?? true {
                update(&model, value)
                to?.accept(model)
            }
        })
    }

    func bind<T>(to: BehaviorRelay<T>,
                 predicate: ((T?, Element) -> Bool)? = nil,
                 update: @escaping (inout T, Element) -> Void) -> Disposable {
        subscribe(onNext: { [weak to] value in
            guard var model = to?.value else { return }
            if predicate?(model, value) ?? true {
                update(&model, value)
                to?.accept(model)
            }
        })
    }
}

extension ObservableType {
    /**
     Leverages instance method currying to provide a weak wrapper around an instance function

     - parameter obj:    The object that owns the function
     - parameter method: The instance function represented as `InstanceType.instanceFunc`
     */
    fileprivate func weakify<A: AnyObject, B>(_ obj: A, method: ((A) -> (B) -> Void)?) -> ((B) -> Void) {
        return { [weak obj] value in
            guard let obj = obj else { return }
            method?(obj)(value)
        }
    }

    fileprivate func weakify<A: AnyObject>(_ obj: A, method: ((A) -> () -> Void)?) -> (() -> Void) {
        return { [weak obj] in
            guard let obj = obj else { return }
            method?(obj)()
        }
    }

    /**
     Subscribes an event handler to an observable sequence.

     - parameter weak: Weakly referenced object containing the target function.
     - parameter on: Function to invoke on `weak` for each event in the observable sequence.
     - returns: Subscription object used to unsubscribe from the observable sequence.
     */
    public func subscribe<A: AnyObject>(weak obj: A, _ on: @escaping (A) -> (RxSwift.Event<Self.Element>) -> Void) -> Disposable {
        return subscribe(weakify(obj, method: on))
    }

    /**
     Subscribes an element handler, an error handler, a completion handler and disposed handler to an observable sequence.

     - parameter weak: Weakly referenced object containing the target function.
     - parameter onNext: Function to invoke on `weak` for each element in the observable sequence.
     - parameter onError: Function to invoke on `weak` upon errored termination of the observable sequence.
     - parameter onCompleted: Function to invoke on `weak` upon graceful termination of the observable sequence.
     - parameter onDisposed: Function to invoke on `weak` upon any type of termination of sequence (if the sequence has
     gracefully completed, errored, or if the generation is cancelled by disposing subscription)
     - returns: Subscription object used to unsubscribe from the observable sequence.
     */
    public func subscribe<A: AnyObject>(
        weak obj: A,
        onNext: ((A) -> (Self.Element) -> Void)? = nil,
        onError: ((A) -> (Error) -> Void)? = nil,
        onCompleted: ((A) -> () -> Void)? = nil,
        onDisposed: ((A) -> () -> Void)? = nil
    )
        -> Disposable {
        let disposable: Disposable

        if let disposed = onDisposed {
            disposable = Disposables.create(with: weakify(obj, method: disposed))
        } else {
            disposable = Disposables.create()
        }

        let observer = AnyObserver { [weak obj] (error: RxSwift.Event<Self.Element>) in
            guard let obj = obj else { return }
            switch error {
            case let .next(value):
                onNext?(obj)(value)
            case let .error(error):
                onError?(obj)(error)
                disposable.dispose()
            case .completed:
                onCompleted?(obj)()
                disposable.dispose()
            }
        }

        return Disposables.create(asObservable().subscribe(observer), disposable)
    }

    /**
     Subscribes an element handler to an observable sequence.

     - parameter weak: Weakly referenced object containing the target function.
     - parameter onNext: Function to invoke on `weak` for each element in the observable sequence.
     - returns: Subscription object used to unsubscribe from the observable sequence.
     */
    public func subscribeNext<A: AnyObject>(weak obj: A, _ onNext: @escaping (A) -> (Self.Element) -> Void) -> Disposable {
        return subscribe(onNext: weakify(obj, method: onNext))
    }

    /**
     Subscribes an error handler to an observable sequence.

     - parameter weak: Weakly referenced object containing the target function.
     - parameter onError: Function to invoke on `weak` upon errored termination of the observable sequence.
     - returns: Subscription object used to unsubscribe from the observable sequence.
     */
    public func subscribeError<A: AnyObject>(weak obj: A, _ onError: @escaping (A) -> (Error) -> Void) -> Disposable {
        return subscribe(onError: weakify(obj, method: onError))
    }

    /**
     Subscribes a completion handler to an observable sequence.

     - parameter weak: Weakly referenced object containing the target function.
     - parameter onCompleted: Function to invoke on `weak` graceful termination of the observable sequence.
     - returns: Subscription object used to unsubscribe from the observable sequence.
     */
    public func subscribeCompleted<A: AnyObject>(weak obj: A, _ onCompleted: @escaping (A) -> () -> Void) -> Disposable {
        return subscribe(onCompleted: weakify(obj, method: onCompleted))
    }
}
