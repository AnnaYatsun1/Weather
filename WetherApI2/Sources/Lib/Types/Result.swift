//
//  Result.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 21/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

//extension Result {
//    // ResultProtocol
//    public typealias Value = Success
//    public typealias Error = Failure
//} 

public enum Result<Value> {
    case success(Value)
    case error(Error)
    
    init(success x: Value) {
        self = .success(x)
    }
    
    init(error: Error) {
        self = .error(error)
    }
    public static func lift<Value>(_ value: Value) -> Result<Value> {
        return .success(value)
    }
    
    public static func lift<Error: Swift.Error>(_ error: Error) -> Result<Error> {
        return .error(error)
    }

}

