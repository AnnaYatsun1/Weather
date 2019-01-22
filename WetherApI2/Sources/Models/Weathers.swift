//
//  Weather.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

final class Weathers: Decodable  {

    enum CodingKeys: String, CodingKey {
        case main = "main"
    }
    
    private(set) var main: Main?    
    
    class Main: Decodable {
        
        var delegate: ModelDelegateWeather?
        
        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
        }
        
        public var temperature: Double?
//        public var timestamp: Date
//            init(temperature: Temperature) {
//                self.temperature =  temperature
//                print(temperature.temp)
//        //        self.timestamp = Date()
//            }
        
    }
}
//
//public class Weather: Decodable {
//    
//    var temperature: Temperature?
////    var timestamp: Date
//    
//    init(temperature: Temperature) {
//        self.temperature =  temperature
//        print(temperature.temp)
////        self.timestamp = Date()
//    }
//}
//
//class Temperature: Decodable {
//    var temp: Double
//    
//    init(temp: WeatherAPI) {
//        self.temp = temp.main.temp
//    }
//}
