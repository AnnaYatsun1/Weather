//
//  Weather.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import  RealmSwift

 class Weather {
    public var temperature: Double
    public var id: String
    
    init(temperature: Double, id: String) {
        self.temperature = temperature
        self.id = id
    }
    
    convenience init(weatherRLM: WeatherRLM_) {
        self.init(temperature: weatherRLM.temperature.value!, id: weatherRLM.id)
    }
}

@objcMembers class WeatherRLM_: RLMModel {
    
    let temperature = RealmOptional<Double>()
    
//    public dynamic var temperature: Double? 
    
    convenience init(temperatura: Double? = nil, id: String) {
        self.init()
        self.temperature.value = temperatura
        self.id = id
    }
    
    convenience init(weather: Weather) {
        self.init(temperatura: weather.temperature, id: weather.id)
    }
}
