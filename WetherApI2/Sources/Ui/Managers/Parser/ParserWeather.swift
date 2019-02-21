//
//  ParserWeather.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 07/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class ParserWeather: Parser<WeatherAPI> {
    public func convert(data: Data) -> Result<Weather, ParserErrors> {
        return self.object(from: data)
            .map { Weather(temperature: $0.main.temp, id: $0.sys.country) } 
    }
    
//    public func convert(data: Result<Data, ParserErrors>) -> Result<Weather, ParserErrors> {
//        return self.object(from: data)
//            .map { Weather(temperature: $0.main.temp, id: $0.sys.country) } 
//    }
}

