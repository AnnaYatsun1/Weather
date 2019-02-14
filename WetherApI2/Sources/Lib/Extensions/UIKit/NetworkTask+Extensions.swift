//
//  NetworkTask.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

extension NetworkTask {
    
    class func cancelled() -> NetworkTask {
        let task = NetworkTask.init(task: .init())
        
        task.cancel()
        
        return task
    }
}
