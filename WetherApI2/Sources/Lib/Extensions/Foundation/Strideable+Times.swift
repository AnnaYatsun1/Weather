//
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

extension Strideable where Self.Stride: SignedInteger, Self: ExpressibleByIntegerLiteral {
    
    public func times(_ execute: () -> ()) {
        (0..<self).forEach { _ in
            execute()
        }
    }
}
