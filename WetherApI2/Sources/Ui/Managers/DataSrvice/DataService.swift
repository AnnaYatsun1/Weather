//
//  DataService.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 20/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import RealmSwift

class DataService: Provider {
    
    typealias DatabaseObject = RealmSwift.Object
    
    private let realm: Realm?
    
    init(database: Realm? = Realm.current) {
        self.realm = database
    }
    
    func getObjects<T: Object>(type: T.Type) -> Result<[T], DatabaseError> {
        
        let results = self.realm?.objects(type)
//        let results_ = self.realm?.objects(type).array()

    
        if let results = results { //TODO: Fix with optional chaining, or remove second return
            return results.isEmpty ? Result(error: .error) : Result(value: results.array())
        } else {
            return Result(error: .error)
        }    
    }
    
    func get(type: Object.Type, key: String) -> Object? {
        guard let database = self.realm else {
            print("instance not available")
            return nil
        }
//        self.realm?.writeObject {
//            $0.object(ofType: type, forPrimaryKey: key)
//        }
        return database.object(ofType: type, forPrimaryKey: key)
    }
    
    func delete(object: Object) {
        self.realm?.writeObject { 
            $0.delete(object)
            print("data: \(object.description)")
        } 
    }
    
    func save(object: Object) {
        self.realm?.writeObject { 
            $0.add(object, update: true)
        }
    }
    
    func save(objects: [Object]) {
       self.realm?.writeObject {
            $0.add(objects, update: true)
        }
    }
}

    
   
