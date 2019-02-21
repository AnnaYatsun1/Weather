//
//  ID.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 21/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation


public struct ID: Hashable, Comparable, CustomStringConvertible, ExpressibleByIntegerLiteral {
    
    public let value: Int
    
    public init(_ value: Int) {
        self.value = value
    }
    
   
    public init(integerLiteral value: Int) {
        self.init(value)
    }

    public init?(string: String) {
        guard let value = Int(string) else { return nil }
        self.init(value)
    }
    
    public static func <(lhs: ID, rhs: ID) -> Bool {
        return lhs.value < rhs.value
    }

    public static func ==(lhs: ID, rhs: ID) -> Bool {
        return lhs.value == rhs.value
    }
    
    public var hashValue: Int {
        return self.value.hashValue
    }
    
    public var description: String {
        return self.value.description
    }
}
