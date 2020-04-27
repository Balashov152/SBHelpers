//
//  ActivityIndicator.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 10/18/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import RxCocoa
import RxSwift

private struct ActivityToken<Element>: ObservableConvertibleType, Disposable {
    private let _source: Observable<Element>
    private let _dispose: Cancelable

    init(source: Observable<Element>, disposeAction: @escaping () -> Void) {
        _source = source
        _dispose = Disposables.create(with: disposeAction)
    }

    func dispose() {
        _dispose.dispose()
    }

    func asObservable() -> Observable<Element> {
        return _source
    }
}

/**
 Enables monitoring of sequence computation.

 If there is at least one sequence computation in progress, `true` will be sent.
 When all activities complete `false` will be sent.
 */
open class ActivityIndicator: SharedSequenceConvertibleType {
    public typealias Element = Bool
    public typealias SharingStrategy = DriverSharingStrategy

    private let _lock = NSRecursiveLock()
    private let _relay = BehaviorRelay(value: 0)
    private let _loading: SharedSequence<SharingStrategy, Bool>

    public init() {
        _loading = _relay.asDriver()
            .map { $0 > 0 }
            .distinctUntilChanged()
    }

    func trackActivityOfObservable<Source: ObservableConvertibleType>(_ source: Source) -> Observable<Source.Element> {
        return Observable.using({ () -> ActivityToken<Source.Element> in
            self.increment()
            return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
        }) { trace in
            trace.asObservable()
        }
    }

    private func increment() {
        _lock.lock()
        _relay.accept(_relay.value + 1)
        _lock.unlock()
    }

    private func decrement() {
        _lock.lock()
        _relay.accept(_relay.value - 1)
        _lock.unlock()
    }

    public func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        return _loading
    }
}

open class IdentityActivityIndicator: SharedSequenceConvertibleType {
    public struct IdentityBool: Equatable {
        let identity: String?
        let active: Bool
    }

    public typealias Element = IdentityBool
    public typealias SharingStrategy = DriverSharingStrategy

    public var identity: String?

    private let _lock = NSRecursiveLock()
    private let _relay = BehaviorRelay(value: 0)

    private lazy var _loading: SharedSequence<SharingStrategy, IdentityBool> = {
        _relay.asDriver()
            .map { [weak self] in .init(identity: self?.identity, active: $0 > 0) }
            .distinctUntilChanged()
    }()

    fileprivate func trackActivityOfObservable<Source: ObservableConvertibleType>(_ source: Source) -> Observable<Source.Element> {
        return Observable.using({ () -> ActivityToken<Source.Element> in
            self.increment()
            return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
        }) { trace in
            trace.asObservable()
        }
    }

    private func increment() {
        _lock.lock()
        _relay.accept(_relay.value + 1)
        _lock.unlock()
    }

    private func decrement() {
        _lock.lock()
        _relay.accept(_relay.value - 1)
        _lock.unlock()
    }

    public func asSharedSequence() -> SharedSequence<DriverSharingStrategy, IdentityActivityIndicator.IdentityBool> {
        return _loading
    }
}

public protocol ActivityTracker {
    var activityIndicator: ActivityIndicator { get }
}

extension PrimitiveSequence where Trait == SingleTrait {
    public func trackActivity(_ activityIndicator: ActivityIndicator) -> Single<Element> {
        return activityIndicator.trackActivityOfObservable(self).asSingle()
    }

    public func trackActivity(activityTracker: ActivityTracker) -> Single<Element> {
        return activityTracker.activityIndicator.trackActivityOfObservable(self).asSingle()
    }

    public func trackIdentityActivity(identity: String, indicator: IdentityActivityIndicator) -> Single<Element> {
        indicator.identity = identity
        return indicator.trackActivityOfObservable(self).asSingle()
    }

    public func trackIdentityActivityJ<Identity: Equatable>(identity: Identity, indicator: IdentityActivityIndicatorJ<Identity>) -> Single<Element> {
        indicator.identity = identity
        return indicator.trackActivityOfObservable(self).asSingle()
    }
}

extension Observable {
    public func trackActivity(activityTracker: ActivityTracker) -> Observable<Element> {
        return activityTracker.activityIndicator.trackActivityOfObservable(self)
    }
}

open class IdentityActivityIndicatorJ<Identity: Equatable>: SharedSequenceConvertibleType {
    public struct IdentityBool<Identity: Equatable>: Equatable {
        public static func == (lhs: IdentityActivityIndicatorJ<Identity>.Element,
                               rhs: IdentityActivityIndicatorJ<Identity>.Element) -> Bool {
            lhs.identity == rhs.identity
        }

        let identity: Identity?
        let active: Bool
    }

    public typealias Element = IdentityBool<Identity>
    public typealias SharingStrategy = DriverSharingStrategy

    public var identity: Identity?

    private let _lock = NSRecursiveLock()
    private let _relay = BehaviorRelay(value: 0)

    private lazy var _loading: SharedSequence<SharingStrategy, IdentityBool<Identity>> = {
        _relay.asDriver()
            .map { [weak self] in .init(identity: self?.identity, active: $0 > 0) }
            .distinctUntilChanged()
    }()

    public func asSharedSequence() -> SharedSequence<DriverSharingStrategy, Element> {
        _loading
    }

    fileprivate func trackActivityOfObservable<Source: ObservableConvertibleType>(_ source: Source) -> Observable<Source.Element> {
        return Observable.using({ () -> ActivityToken<Source.Element> in
            self.increment()
            return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
        }) { trace in
            trace.asObservable()
        }
    }

    private func increment() {
        _lock.lock()
        _relay.accept(_relay.value + 1)
        _lock.unlock()
    }

    private func decrement() {
        _lock.lock()
        _relay.accept(_relay.value - 1)
        _lock.unlock()
    }
}
