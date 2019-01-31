//
//  NetworkManager.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Parser<Object: Decodable> {
    
    
    func decoder(from data: Data?, completion: (Object?) -> ()) {
        var decoded: Object?

        if let data = data {
            do {    
                decoded = try JSONDecoder().decode(Object.self, from: data)
            } catch {	
            print("error")
            } 
        } else {
            print()
        } 
        
        completion(decoded) 
    }
}
