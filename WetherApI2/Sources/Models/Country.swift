//
//  Country.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Country {

    var name: String?
    var capital: String?
    var weather: Weather?
    
    init(name: String, capital: String, weather: Weather? = nil) {
        self.name = name
        self.capital = capital
        self.weather = weather        
    }
}
