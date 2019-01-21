//
//  Weather.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

//final class Weathers: Decodable  {
//
//    enum CodingKeys: String, CodingKey {
//        case main = "main"
//    }
//    
//    private(set) var main: Main?    
//    
//    class Main: Decodable {
//        
//        var delegate: ModelDelegateWeather?
//        
//        enum CodingKeys: String, CodingKey {
//            case temperature = "temp"
//        }
//        
//        public var temperature: Double? = nil {
//            didSet {
//                self.delegate?.update()
//            }
//        }
//    }
//}

public class Weather: Decodable {
    
    var temperature: Temperature?
    var timestamp: Date
    
    init(temperature: Temperature) {
        self.temperature =  temperature
        self.timestamp = Date()
    }
}

class Temperature: Decodable {
    var temp: Double
    
    init(temp: WeatherAPI.Main) {
        self.temp = temp.temp
    }
}
