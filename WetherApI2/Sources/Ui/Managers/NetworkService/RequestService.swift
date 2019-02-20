//
//  Manager.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 25/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import  Alamofire

enum APPError: Error {
    
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

protocol RequestServiceType {
    
    func requestData(url: URL, completion: @escaping (Result<Data?, APPError>) -> Void) -> NetworkTask
}

class RequestService: RequestServiceType { //TODO: second RequestServiceType with alamofire session 

    private(set) var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func requestData(url: URL, completion: @escaping (Result<Data?, APPError>) -> Void) -> NetworkTask {
//        self.requestData(url: <#T##URL#>, completion: <#T##(Result<Data?, APPError>) -> Void#>)
        let requestN = request(url).response { response in 
            completion(
                Result(
                    success: response.data, 
                    error: response.error.map { _ in APPError.dataNotFound }, 
                    default: APPError.dataNotFound)
            )
        }
        
        defer {
            requestN.resume()
        }
        
        return requestN.task.map(NetworkTask.init) ?? .cancelled()
    }
}



