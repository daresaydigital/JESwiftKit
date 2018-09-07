//
//  RxExtensions.swift
//  TeliaZone
//
//  Created by Joseph Elliott on 2018-02-01.
//  Copyright © 2018 Telia Zone. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {
    
    /// Continue after completion
    public func then<U>(_ closure: () -> Observable<U>) -> Observable<U> {
        return self.then(closure())
    }
    
    /// Continue after completion
    public func then<U>(_ replacement: Observable<U>) -> Observable<U> {
        return Observable.create { observer in
            let observerDisposable = CompositeDisposable.init()
            
            let disposable = self.asObservable().subscribe { event in
                switch event {
                case let .error(error):
                    observer.onError(error)
                case .completed:
                    _ = observerDisposable.insert(replacement.subscribe(observer))
                case .next:
                    break
                }
            }
            _ = observerDisposable.insert(disposable)
            return observerDisposable
        }
    }
    
    /// Allows an observable to report back to a subject, essentially forking the observable
    /// Useful for testing.
    public func report(to reporter: ReplaySubject<E>?) -> Observable<E> {
        return self.do(onNext: { (item) in
            reporter?.onNext(item)
        }, onError: { (err) in
            reporter?.onError(err)
        }, onCompleted: {
            reporter?.onCompleted()
        })
    }
    
    /// An observable function which allows a side-effect inducing Completable to possibly throw an error into an observable stream.
    /// If Completable succeeds, the observable continues without interruption.
    public func doSafe(_ closure: @escaping (E) -> Completable?) -> Observable<E> {
        return self.flatMap { (item) -> Observable<E> in
            
            if let completable = closure(item) {
                return completable.asObservable().materialize().map({ (event) -> E in
                    switch event {
                    case .completed:
                        return item
                    case let .error(err):
                        throw err
                    case .next:
                        // this is a Never, this should never occur.
                        return item
                    }
                })
            } else {
                return Observable.just(item)
            }
        }
    }
    
    /// Adds a minimum delay time to the observable so it won't complete before the minimum delay
    /// Useful if you want to display a loading screen
    /// Terminates if you have an error...really we would want to delay the error also.
    /// What we probably want is a mergeDelayError but it doesn't exist in RxSwift.
    public func minimumDelay(_ delay: RxTimeInterval, scheduler: SchedulerType) -> Observable<E> {
        
        let interval = Observable<Int>.just(1).delay(delay, scheduler: scheduler)
        return Observable.zip(interval, self).map { $0.1 }
    }

    /// An observable function which allows a final side-effect in the form of a Completable before ending an observable chain.
    /// If the observable is not errored, this does nothing.
    public func lastChance(onError: @escaping ((Error) -> Completable)) -> Observable<E> {
        return self.map { (item) -> (item: E?, error: Error?) in
            return (item: item, error: nil)
        }.catchError { (error) -> Observable<(item: Self.E?, error: Error?)> in
            return Observable.just((item: nil, error))
        }.flatMap { (arg) -> Observable<E> in
            let (possibleItem, possibleError) = arg
            
            if let error = possibleError {
                let completable = onError(error)
                return completable.asObservable().materialize().map { _ in throw error }
            } else if let item = possibleItem {
                return Observable.just(item)
            } else {
                return Observable.empty()
            }
        }
    }
}

extension PrimitiveSequence where TraitType == SingleTrait {
    public func asMaybe() -> PrimitiveSequence<MaybeTrait, Element> {
        return self.asObservable().asMaybe()
    }
    
    public func asCompletable() -> PrimitiveSequence<CompletableTrait, Never> {
        return self.asObservable().flatMap { _ in Observable<Never>.empty() }.asCompletable()
    }
}

extension PrimitiveSequence where TraitType == CompletableTrait, ElementType == Swift.Never {
    public func asMaybe() -> PrimitiveSequence<MaybeTrait, Element> {
        return self.asObservable().asMaybe()
    }
}

public extension Single {
    
    /// Continue after completion
    public func then<U>(_ closure: () -> Single<U>) -> Single<U> {
        return self.then(closure())
    }
    
    /// Continue after completion
    public func then<U>(_ replacement: Single<U>) -> Single<U> {
        return Single.create { single in
            let observerDisposable = CompositeDisposable.init()
            
            let disposable = self.asObservable().subscribe { event in
                switch event {
                case let .error(error):
                    single(.error(error))
                case .completed:
                    _ = observerDisposable.insert(replacement.subscribe(single))
                case .next:
                    break
                }
            }
            _ = observerDisposable.insert(disposable)
            return observerDisposable
        }
    }
}

public extension Single where TraitType == SingleTrait {
    
    /// Adds a minimum delay time to the observable so it won't complete before the minimum delay
    /// Useful if you want to display a loading screen
    public func minimumDelay(_ delay: RxTimeInterval, scheduler: SchedulerType) -> Single<Element> {
        
        let interval = Single<Int>.just(1).delay(delay, scheduler: scheduler)
        return Single.zip(interval, self).map { $0.1 }
    }
}

extension PrimitiveSequence where TraitType == CompletableTrait, ElementType == Swift.Never {
    
    public func then<U>(_ closure: () -> Observable<U>) -> Observable<U> {
        return self.then(closure())
    }
    
    public func then(_ closure: () -> Completable) -> Completable {
        return self.then(closure())
    }
    
    public func then<U>(_ replacement: Observable<U>) -> Observable<U> {
        return Observable.create { observer in
            let observerDisposable = CompositeDisposable.init()
            
            let disposable = self.asObservable().subscribe { event in
                switch event {
                case let .error(error):
                    observer.onError(error)
                case .completed:
                    _ = observerDisposable.insert(replacement.subscribe(observer))
                case .next:
                    break
                }
            }
            _ = observerDisposable.insert(disposable)
            return observerDisposable
        }
    }
    
    public func then(_ replacement: Completable) -> Completable {
        return self.then(replacement.asObservable()).asCompletable()
    }
}

