//
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public class ObservableObject<Value> {

    public typealias Object = AnyObject
    public typealias Handler = (Value, Object?) -> ()
    
    private let atomicObservers = Atomic([Observer]())

    // MARK: - Public API
    public func observer(handler: @escaping Handler) -> Observer {
        return self.atomicObservers.modify {
            let observer = Observer(target: self, handler: handler)
            $0.append(observer)
            
            return observer
        }
    }
    
    public func notify(new: Value, object: Object? = nil) {
        self.atomicObservers.modify { observers in
            observers = observers.filter { $0.isObserving }
            observers.forEach { $0.handler(new, object) }
        }
    }
}
