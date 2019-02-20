//
//  ParserCountry.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 07/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class ParserCountry: Parser<[CountryAPI]> {
   
    public func convert(data: Data) -> Result<[Country], ParserErrors> {
      return self.object(from: data)
        .map {  $0.map { Country(name: $0.name, capital: $0.capital, id: $0.alpha2Code) }} 
    }
}
