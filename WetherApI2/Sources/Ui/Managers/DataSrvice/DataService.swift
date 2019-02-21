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
    typealias DatabaseRealm = () -> Realm?
    
    private let realm: () -> Realm?
    
    init(database: @escaping DatabaseRealm = { Realm.current }) {
        self.realm = database
    }
    
    func getObjects<T: Object>(type: T.Type) -> Result<[T], DatabaseError> {
        return Result(
            success: self.realm()?.objects(type).array(), 
            error: .error, 
            default: .error
        )  
    }
    
    func get<T: Object>(type: T.Type, key: String) -> T? {
        return self.realm()?.object(ofType: type, forPrimaryKey: key)
    }
    
    func delete(object: Object) {
        self.realm()?.writeObject { 
            $0.delete(object)
        } 
    }
    
    func save(object: Object) {
        self.realm()?.writeObject { 
            $0.add(object, update: true)
        }
    }
    
    func save(objects: [Object]) {
      self.realm()?.writeObject { 
            $0.add(objects, update: true)
        }
    }
}

    
   
