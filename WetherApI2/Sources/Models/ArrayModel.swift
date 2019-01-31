//
//  ArrayModel.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 28/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
 
class ArrayModel<T: AnyObject>: BaseModel { 

    public private(set) var values = Atomic([Model<T>]())
    
    init(values: [T]) {
        super.init()

        let notificator = self.notificator
        let wrapped = values.map {
            Model($0, willSet: notificator, didSet: notificator)
        }
        
        self.values = Atomic(wrapped)
    }
    
    public var count: Int {
        return self.values.value.count
    }
    
    public lazy var notificator = { (event: State) in 
        self.notify(new: event)
    }
    
    var isEmpty: Bool {
        return self.values.value.isEmpty
    }
    
    public func add(value: T) {
        self.values.value.append(Model(value, willSet: self.notificator, didSet: self.notificator))
    }
    
    
    public func update(values: [T]) {
        self.notify(new: .updateStarted)
        self.values.value = values.map { Model($0, willSet: self.notificator, didSet: self.notificator) }
        self.notify(new: .updateFinished)
    }
}
