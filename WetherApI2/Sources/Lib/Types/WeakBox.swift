//
//  WeakBox.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 20/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class WeakBox<Wrapped: AnyObject>: Equatable {
    
    public var isEmpty: Bool { return self.wrapped.isNone }
    public private(set) weak var wrapped: Wrapped?
    
    // MARK: - Initialization
    init(_ strongObject: Wrapped) {
        self.wrapped = strongObject
    }
    
    // MARK: - Equatable & Hashable
    static func == (lhs: WeakBox, rhs: WeakBox) -> Bool {
        if
            let lhs = lhs.wrapped,
            let rhs = rhs.wrapped {
            return lhs === rhs
        } else {
            return false
        }
    }
}
