//
//  Country.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Country: Decodable, Equatable {

    var name: String?
    var capital: String?
    var weather: Weathers?
    
    init(name: String, capital: String, weather: Weathers? = nil) {
        self.name = name
        self.capital = capital
        self.weather = weather
    }
    
    convenience init (apiJson: CountryAPI) {
        self.init(name: apiJson.name, capital: apiJson.capital)
    }
    
    public static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name
    }
}
