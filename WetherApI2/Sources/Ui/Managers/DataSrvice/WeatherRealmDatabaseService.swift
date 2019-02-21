//
//  WeatherDatabaseService.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 20/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class WeatherDatabaseService: RealmDataService, WeatherDatabaseServiceProtocol {
    
    public func loadWeather(country: Country) -> Weather? {
        return self.get(type: WeatherRLM.self, key: country.id)
            .flatMap { Weather(weatherRLM: $0) }
    }
    
     public func saveWeather(_ weather: Weather, country: Country) -> () {
      
        if let country_ = self.get(type: CountryRLM.self, key: country.id) {
            
            self.update(object: country_) {
                if $0.weather != nil {
                    $0.weather?.temperature.value = weather.temperature
                } else {
                    $0.weather = WeatherRLM(weather: weather)
                }
            }
            self.save(object: country_)
        }
//        country.weather = weather
//        let weather = WeatherRLM(weather: weather) 
//        self.save(object: weather)
    }
}
