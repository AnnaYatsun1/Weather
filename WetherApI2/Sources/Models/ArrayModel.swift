//
//  ArrayModel.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 28/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
 
class ArrayModel<T: AnyObject>: ObservableObject<Event> { 

    public private(set) var values = [T]()
    private var observer = CancellableObject()
    
    init(values: [T]) {
        super.init()

        self.values = values
    }
    
    public var count: Int {
        return self.values.count
    }
    
    public var isEmpty: Bool {
        return self.values.isEmpty
    }
    
    public func add(value: T) {
        self.values.append(value)
        self.notify(new: .add)
    }
    public func addAll(values: [T]) {
        self.values.append(contentsOf: values)
        self.notify(new: .add)
    }
    
    public func remove(at index: Int) {
        self.values.remove(at: index)
        self.notify(new: .remove)
    }
    
    public func removeAll() {
        self.values.removeAll()
        self.notify(new: .remove)
    }
    
    subscript(index: Int) -> Model<T> {
        let model = Model(self.values[index])
        model.observer(handler: self.notify)

        return model
        
    }
}


