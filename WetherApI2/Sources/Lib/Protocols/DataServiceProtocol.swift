//
//  DataServiceProtocol.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 20/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public enum DatabaseError: Error {
    case error
}

public protocol DataServiceProtocol: class {
    
    associatedtype DatabaseObject  //  Weather of Counry etc

    func getObjects(type: DatabaseObject.Type) -> Result<[DatabaseObject], DatabaseError>
    func get(type: DatabaseObject.Type, key: String) -> DatabaseObject?
    func delete(object: DatabaseObject)
    func save(object: DatabaseObject)
    func save(objects: [DatabaseObject])
}
