//
//  RequestService.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 20/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class RequestService {
    private(set) var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func requestData(url: URL, completion: @escaping (Data?, Error?) -> ()) -> NetworkTask {

      let requst = self.requestData(url: url) { (data, error) in
            completion(data, error)
        }
        
        return requst 
    }
}
