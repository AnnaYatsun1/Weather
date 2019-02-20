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
    
    func getObjects(type: Object.Type) -> Result<[Object], DatabaseError> {
        
        let results = self.realm?.objects(type)
        
        if let results = results {
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
      
        return database.object(ofType: type, forPrimaryKey: key)
    }
    
    func delete(object: Object) {
            try? self.realm?.write {
                print("data: \(object.description)")
                self.realm?.delete(object)
        } 
    }
    
    func save(object: Object) {
        try?  self.realm?.write {
            print("\(object.description)")
            self.realm?.add(object, update: true)
        }
    }
    
    func save(objects: [Object]) {
        try? self.realm?.write {
            print("data: \(Array(objects).description) ")
            self.realm?.add(objects, update: true)
        }
    }
}

    
   
