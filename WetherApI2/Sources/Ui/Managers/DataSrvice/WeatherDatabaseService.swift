//
//  WeatherDatabaseService.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 20/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class WeatherDatabaseService: DataService {
    
    public func loadWeather(country: Country) -> Weather? {
        return self.get(type: WeatherRLM_.self, key: country.id)
            .flatMap { Weather(weatherRLM: $0) }
    }
    
     public func saveWeather(_ weather: Weather, country: Country) -> () {
        country.weather = weather
        let weather = WeatherRLM_(weather: weather) 
        self.save(object: weather)
    }
}
