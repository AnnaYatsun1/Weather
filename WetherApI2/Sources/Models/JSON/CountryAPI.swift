//
//  CountryAPI.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 17/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

typealias Welcomes = [CountryAPI]

public struct CountryAPI: Decodable {
    
     enum CodingKeys: String, CodingKey {
        case name
        case topLevelDomain
        case alpha2Code
        case alpha3Code
        case callingCodes
        case capital
        case altSpellings
        case region
        case subregion
        case population
        case latlng
        case demonym
        case area
        case gini
        case timezones
        case borders
        case nativeName
        case numericCode
        case currencies
        case languages
        case translations
        case flag
        case regionalBlocs
        case cioc
    }
    
    let name: String
    let topLevelDomain: [String]
    let alpha2Code: String
    let alpha3Code: String
    let callingCodes: [String]
    let capital: String
    let altSpellings: [String?]
    let region: String
    let subregion: String
    let population: Int
    let latlng: [Double]
    let demonym: String
    let area: Double?
    let gini: Double?
    let timezones: [String]
    let borders: [String]
    let nativeName: String
    let numericCode: String?
    let currencies: [Currency]
    let languages: [Language]
    let translations: Translations
    let flag: String
    let regionalBlocs: [RegionalBloc]
    let cioc: String?
    
}

extension CountryAPI {
  public struct Currency: Decodable {
        let code: String?
        let name: String?
        let symbol: String?
    }
}

extension CountryAPI {
   public struct Language: Decodable {
        let iso6391: String?
        let iso6392: String
        let name: String 
        let nativeName: String
    
        enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name
        case nativeName
        }
    }
}

extension CountryAPI {
  public  struct RegionalBloc: Decodable {
        
        public enum CodingKeys: String, CodingKey {
            case acronym
            case name
            case otherAcronyms
            case otherNames
        }
        
        let acronym: String
        let name: String
        let otherAcronyms: [String]
        let otherNames: [String]
    }
}

extension CountryAPI {
    struct Translations: Decodable {
        let de: String?
        let es: String?
        let fr: String?
        let it: String?
        let br: String?
        let pt: String?
        let nl: String?
        let hr: String?
        let fa: String
    }
}
