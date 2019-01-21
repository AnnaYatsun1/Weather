//
//  MyModel.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 17/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

class MyModel: ObservableObject<MyModel.Event> {
    
    public enum Event {
        case tookIntoObservation
        case notTookIntoObservation
        case needToUpdate
    }
    
    public var weather: WeatherAPI
    public var countries: CountryAPI
    
    init(weather: WeatherAPI, countries: CountryAPI) {
        self.weather = weather
        self.countries = countries
    }
}

