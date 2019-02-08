//
//  ParserCountry.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 07/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class ParserCountry: Parser<[CountryAPI]> {
    
    public func convert(data: Data) -> Result<[Country]> {
        let countryJSON = super.decoders(from: data)
        switch countryJSON {
        case .success(let json):
            let countries = json.map {
                Country(name: $0.name, capital: $0.capital)
            }
            
            return .success(countries)
        case .error(let error): return .error(error)
            
        }
    }
}
