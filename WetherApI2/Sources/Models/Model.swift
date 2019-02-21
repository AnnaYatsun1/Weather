//
//  Model.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 28/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Model<Value>: ObservableObject<Event> {
       
    var value: Value {
        get { return self.mutableValue }
        set { self.modify { $0 = newValue } }
    }

    private var mutableValue: Value

    init(_ value: Value) {      
        self.mutableValue = value
    }

    func modify<Result>(_ action: (inout Value) -> Result) -> Result {
        defer { self.notify(new: .update) }
        return action(&self.mutableValue)
    }
}
