//
//  NetworkManager.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation


class MyError: Error {
    
}
class Parser<Object: Decodable> {
    
    func decoders(from data: Data?) -> Result<Object>  {
    
        var result: Result<Object>

        result = data
            .flatMap { try? JSONDecoder().decode(Object.self, from: $0) }
            .map { Result.success($0) }
            ?? .error(MyError())

        return result
    }
}
