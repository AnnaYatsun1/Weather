//
//  Realm+Extensions.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 20/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

import RealmSwift

public extension Realm {
    
    private struct Key {
        static let realmThread = "com.thread.realm.weather"
    }
    
    public static var current: Realm? {
        let key = Key.realmThread
        let thread = Thread.current
        
        return thread.threadDictionary[key]
            .flatMap { $0 as? WeakBox<Realm> }
            .flatMap { $0.wrapped }
            ?? call {
                (try? Realm()).map(
                    side { thread.threadDictionary[key] = WeakBox($0) }
                )
        }
    }
    
    public static func write(_ action: (Realm) -> ()) {
        self.current.do { $0.writeObject(action) }
    }
    
    public func writeObject(_ action: (Realm) -> ()) {
        if self.isInWriteTransaction {
            action(self)
        } else {
            try? self.write { action(self) }
        }
    }
}

