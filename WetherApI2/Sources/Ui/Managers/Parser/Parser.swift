//
//  NetworkManager.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

enum ParserErrors: Error {
    
    case dataError 
}

class Parser<Object: Decodable> {
    
    func object(from data: Data?) -> Result<Object, ParserErrors> {
        return data
            .flatMap { try? JSONDecoder().decode(Object.self, from: $0) }
            .map { Result.success($0) }
            ?? .error(ParserErrors.dataError)
    }
}
