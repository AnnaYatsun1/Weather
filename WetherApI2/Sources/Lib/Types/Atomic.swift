//
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Atomic<Value> {

    typealias PropertyObserver = ((old: Value, new: Value)) -> ()

    public var value: Value {
        get { return self.transform { $0 } }
        set { self.modify { $0 = newValue } }
    }
    
    private var mutableValue: Value
    private let lock: NSRecursiveLock
    private let willSet: PropertyObserver?
    private let didSet: PropertyObserver?
    
    // MARK: - Initialization
    init(
        _ value: Value,
        lock: NSRecursiveLock = NSRecursiveLock(),
        willSet: PropertyObserver? = nil,
        didSet: PropertyObserver? = nil
    ) {
        self.mutableValue = value
        self.lock = lock
        self.willSet = willSet
        self.didSet = didSet
    }
    
    // MARK: - Public API
    public func transform<Result>(_ action: (Value) -> Result) -> Result {
        return self.lock.do {
            action(self.mutableValue)
        }
    }
    
    public func modify<Result>(_ action: (inout Value) -> Result) -> Result {
        return self.lock.do {
            var oldValue = self.mutableValue  //  should make deep copy?
            var newValue = oldValue           //  should make deep copy?
            let result = action(&newValue)
            
            self.willSet?((oldValue, newValue))
            self.mutableValue = newValue
            
            defer {
                self.didSet?((oldValue, self.mutableValue))
            }
            
            return result
        }
    }
}
