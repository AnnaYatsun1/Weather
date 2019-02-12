//
//  CountriesNetworkService.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 07/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

fileprivate struct Constant {
    
    static let mainUrl = "https://restcountries.eu/rest/v2/all"
}

class CountriesNetworkService: RequestServiceType {
    
    private let model = ArrayModel(values: [Country]())
    
    private let parser = ParserCountry()
      
    public func getCountries(_ countrys: ArrayModel<Country>) {
        let urlCountry = URL(string: Constant.mainUrl)
        urlCountry.do { url in 
            self.requestData(url: url) { (result: Result) in 
                result.map { data in 
                 self.parser.convert(data: data!)
                    .map { country in 
                        countrys.addAll(values: country)
                    }
                }
            }
        }
    }
}
