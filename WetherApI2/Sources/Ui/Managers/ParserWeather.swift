//
//  ParserWeather.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 07/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation


class ParserWeather: Parser<WeatherAPI> {
    
    public func convert(data: Data?) -> Result<Weather> {
        //возврат погоды норм
        let weatherJSON = super.decoders(from: data)
//        print(" weatherJson \(weatherJSON)") 
        switch weatherJSON {
        case .success(let json):
            let temperatura = json.main.temp
            let weather = Weather(temperature: temperatura)
//            print("weatherJSON \(weather.temperature)")
            return .success(weather)
        case .error(let error): return .error(error)
        }
    }
}

