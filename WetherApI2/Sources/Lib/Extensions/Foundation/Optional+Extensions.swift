//
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

extension Optional {
    
    public func `do`(_ execute: (Wrapped) -> ()) {
        self.map(execute)
    }
    
    func apply<Result>(_ transform: ((Wrapped) -> Result)?) -> Result? {
        return self.flatMap {
            transform?($0)
        }
    }
    
    public var isNone: Bool {
        get {
            switch self {
            case .none: return true
            case .some: return false
            }
        }
    }

    public var isSome: Bool {
        get { return !self.isNone }
    }
}
