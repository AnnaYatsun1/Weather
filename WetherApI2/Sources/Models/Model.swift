//
//  Model.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 28/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Model<Value> {
   
    typealias PropertyObserver = (State) -> ()
    
    public var value: Value {
        get { return self.mutableValue }
        set { self.modify { $0 = newValue } }
    }
    
    private var mutableValue: Value
    private let willSet: PropertyObserver
    private let didSet: PropertyObserver
    
    init(
        _ value: Value,
        willSet: @escaping PropertyObserver,
        didSet: @escaping PropertyObserver
    ) {
        self.mutableValue = value
        self.willSet = willSet
        self.didSet = didSet
    }
    
    func modify<Result>(_ action: (inout Value) -> Result) -> Result {
            self.willSet(.updateStarted)
            defer { self.didSet((.updateFinished)) }
            return action(&self.mutableValue)
    }
}
