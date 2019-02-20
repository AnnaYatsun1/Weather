//
//  Functional.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 12/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public func identity<Value>(_ value: Value) -> Value {
    return value
}

public func alwaysNil<Ignored, Value>(_ ignored: Ignored) -> Value? {
    return nil
}

public func ignoreInput<Value, Result>(_ action: @escaping () -> Result) -> (Value) -> Result {
    return { _ in
        action()
    }
}

public func returnValue<Value>(_ value: Value) -> () -> Value {
    return { value }
}

public func curry<A, B, C>(f: @escaping (A, B) -> C) -> (A) -> (B) -> C
{
    return { (a: A) -> (B) -> C in
        { (b: B) -> C in
            f(a, b)
        }
    }
}

public func uncurry<A, B, C>(f: @escaping (A) -> (B) -> C) -> (A, B) -> C
{
    return { (a: A, b: B) -> C in
        f(a)(b)
    }
}

public func flip<A, B, C>(f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C
{
    return { (b: B) -> (A) -> C in
        { (a: A) -> C in
            f(a)(b)
        }
    }
}

public func flip<A, B, C>(f: @escaping (A, B) -> C) -> (B, A) -> C
{
    return { (b: B, a: A) -> C in
        f(a, b)
    }
}

//  ex-modify
public func side<Value>(_ value: Value, action: @escaping (inout Value) -> ()) -> Value {
    var newValue = value  //  expected value type
    action(&newValue)
    
    return newValue
}

//  new
public func side<Value>(action: @escaping (inout Value) -> ()) -> (Value) -> (Value) {
    return { side($0, action: action) }
}

public func scope(action: () -> ()) {
    action()
}

public func call<Value>(action: () -> Value) -> Value {
    return action()
}

public func typeString<Object>(_ type: Object.Type) -> String {
    return String(describing: type)
}

public func typeString<Value>(_ value: Value) -> String {
    return typeString(type(of: value))
}
