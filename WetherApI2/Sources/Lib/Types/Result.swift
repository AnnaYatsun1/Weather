//
//  Result.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 21/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

enum ResultErrors: Error {
    
    case couldNotInitialize
}

public enum Result<Value, Error: Swift.Error> {
    
    case success(Value)
    case error(Error)
    
    public init(value: Value) {
        self = .success(value)
    }

    
    public init(error: Error) {
        self = .error(error)
    }

    public static func lift<Value, Error: Swift.Error>(_ value: Value) -> Result<Value, Error> {
        return .success(value)
    }
    
    public static func lift<Value, Error: Swift.Error>(_ error: Error) -> Result<Value, Error> {
        return .error(error)
    }
  
    public var result: Result<Value, Error> {
        return self.analysis(success: {Result(value: $0)}, failure: {Result(error: $0)} )
    }

    public func analysis<Return>(success: (Value) -> Return, failure: (Error) -> Return) -> Return {
        switch self {
        case .success(let value): return success(value)
        case .error(let error): return failure(error)
        }
}

    public func bimap<NewValue, NewError>(
        success: (Value) -> NewValue,
        failure: (Error) -> NewError
        )
        -> Result<NewValue, NewError>
    {
        return self.analysis(
            success: { Result.lift(success($0)) },
            failure: { Result.lift(failure($0)) }
        )
}
   
    public func map<NewValue>(_ transform:(Value) -> NewValue) -> Result<NewValue, Error>
    {
        return self.bimap(success: transform, failure: identity)
    }

    public func flatMap<NewValue>(_ transform: (Value) -> Result<NewValue, Error>) -> Result<NewValue, Error>
    {
        return self.analysis(success: transform, failure: Result.lift)
    }
    
    public func flatMapError<NewError>(_ transform: (Error) -> Result<Value, NewError>) -> Result<Value, NewError>
    {
        return self.analysis(success: Result.lift, failure: transform)
}
}

////    init(success: Value?, error: Error?, `default`: Error) {
////        self = error
////            .map(Result.init)
////            ?? success.map(Result.init)
////            ?? Result(error: ResultErrors.couldNotInitialize)
////    }
////    
////    public static func lift<Value>(_ value: Value) -> Result<Value> {
////        return .success(value)
////    }
////    
////    public static func lift<Error: Swift.Error>(_ error: Error) -> Result<Error> {
////        return .error(error)
////    }
////    
//    public func map<NewValue>(_ transform: (Value) -> NewValue) -> Result<NewValue, Error> {
//        switch self {
//            case let .success(value):
//                return Result<NewValue, Error>(success: transform(value), error: nil, default: ResultErrors.couldNotInitialize) 
//            case let .error(error):
//                return Result<NewValue>(success: nil, error: error, default: ResultErrors.couldNotInitialize)
//        }
//    }
//}
//
