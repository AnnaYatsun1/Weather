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

protocol RequestServiceType {

    func requestData(url: URL, completion: @escaping (Result<Data?, APPError>) -> Void)

}

extension RequestServiceType {
    
    func requestData(url: URL, completion: @escaping (Result<Data?, APPError>) -> Void ) {
        let session = URLSession.shared
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else {
                
                completion(Result.error(APPError.dataNotFound))
                return
            }
//            debugPrint(error)
            completion(Result.success(data))
            
        })
        
        task.resume()
    }
}

