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
    var country: String?
    var weather: Weather?
    
    init(name: String, country: String, weather: Weather? = nil) {
        self.name = name
        self.country = country
        self.weather = weather
    }
    
    convenience init (apiJson: CountryAPI) {
        self.init(name: apiJson.capital, country: apiJson.name)
    }
    
    public static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name
    }
}
