//
//  IDProvider.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 21/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public typealias IDProvider = () -> ID

fileprivate let persistentProviders = Atomic([String: IDProvider]())

public func autoIncrementedIDGenerator() -> IDProvider {
    return autoIncrementedID(1)
}

public func autoIncrementedID(key: String) -> IDProvider {
    return persistentProviders.modify { storage in
        storage[key] ?? call {
            let defaults = UserDefaults.standard
            
            let result = autoIncrementedID(defaults.integer(forKey: key)) {
                defaults.set($0, forKey: key)
            }
            
            storage[key] = result
            
            return result
        }
    }
}

private func autoIncrementedID(_ start: Int, action: Closure.Execute<Int>? = nil) -> IDProvider {
    let value = Atomic(start)
    
    return {
        value.modify {
            let result = $0
            $0 += 1
            action?($0)
            
            return ID(result)
        }
    }
}
