//
//  Country.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import RealmSwift

class Country {

    var name: String
    var capital: String
    var weather: Weather?
    var id: String
    
    init(name: String, capital: String, weather: Weather? = nil, id: String) {
        self.id = id 
        self.name = name
        self.capital = capital
        self.weather = weather        
    }
    
    convenience init(countryRLM: CountryRLM) {
        self.init(name: countryRLM.name!, capital: countryRLM.capital!, id: countryRLM.id)
    }
}

@objcMembers class CountryRLM: RLMModel  {
    
    public dynamic var name: String?
    public dynamic var capital: String?
    public dynamic var weather: WeatherRLM? 
  
    convenience init(name: String? = nil, capital: String? = nil, weather: WeatherRLM? = nil, id: String) {
        self.init()
        self.name = name
        self.capital = capital
        self.weather = weather
        self.id = id
    }
    
    convenience init(country: Country) {
        self.init(name: country.name, capital: country.capital, id: country.id)
    }
}
