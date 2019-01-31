//
//  Weather.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

final class Weather{
    public var temperature: Double?
    
    init(temperature: Double?) {
        self.temperature = temperature
    }
    
    convenience init (apiJson: WeatherAPI) {
        self.init(temperature: apiJson.main.temp)
    }

}

