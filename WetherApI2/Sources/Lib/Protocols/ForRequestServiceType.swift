//
//  RequestServiceType.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 20/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation


protocol RequestServiceType {
    
    func requestData(url: URL, completion: @escaping (Data?, Error?) -> ()) -> NetworkTask
}
