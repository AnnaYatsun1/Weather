//
//  File.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 20/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class CountriesDatabaseService: RealmDataService, CountriesDatabaseServiceProtocol {
    
    func loadCities() -> [Country]? {
        var countries = [Country]()
        
        self.getObjects(type: CountryRLM.self)?
            .forEach { countries.append(Country(countryRLM: $0)) }
        
        return countries
    }
    
    func save(countries: [Country]) {
        countries.forEach { country in 
            let countris = CountryRLM(name: country.name, capital: country.capital, id: country.id)
            self.save(object: countris)
        }
    }
}

