//
//  Manager.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 25/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

enum APPError: Error {
    
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

protocol RequestServiceType: Cancellable {
    var task: URLSessionTask { get }
    func requestData(url: URL, completion: @escaping (Result<Data?, APPError>) -> Void)

}

extension RequestServiceType {
   
    func requestData(url: URL, completion: @escaping (Result<Data?, APPError>) -> Void) {
        let session = URLSession.shared
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        let task = session.dataTask(with: request) { data, response, error in
            completion(
                Result(
                    success: data, 
                    error: error.map { _ in APPError.dataNotFound }, 
                    default: APPError.dataNotFound)
            )
        }
        
        task.resume()
    }
}

