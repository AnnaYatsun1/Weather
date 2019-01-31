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


class Request    {
    let queue = DispatchQueue(label: "requests.queue", qos: .utility)
    func make(url: String, completion: @escaping Closure.Execute<Data>) {
        guard let endpoint = URL(string: url) else {
            print("Error creating endpoint")
            return
        }
        
        URLSession.shared.dataTask(with: endpoint) { (data, response, error) in
        self.queue.async {
            do {
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        if let data = data {
                            completion(data)
                        }
                    }
                }
            } catch {
                print(error)
            } 
        }
        }.resume()
    }
    
    
}
