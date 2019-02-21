//
//  RealmDataService.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 20/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import RealmSwift


class RealmDataService: DataServiceProtocol {
    
    typealias DatabaseRealm = () -> Realm?
    
    private let realm: () -> Realm?
    
    init(database: @escaping DatabaseRealm = { Realm.current }) {
        self.realm = database
    }
    
    func getObjects<T: Object>(type: T.Type) -> [T]? {
        return self.realm()?.objects(type).array() 
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
    
    public func update<T: Object>(object: T, action: (T) -> ()) {
        self.realm()?.writeObject { _ in
            action(object)
        }
    }
}

    
   
