//
//  Manager.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 25/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import Network
import UIKit
//import SocketIO

enum APPError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

class RequestService {
    
    public func requestData(url: URL, completion: @escaping (Data?, Error?) -> ()) {
        URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                completion(data, error) }
            .resume()
    }
}


 
    
