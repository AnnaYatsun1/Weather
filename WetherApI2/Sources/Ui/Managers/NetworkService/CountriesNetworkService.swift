//
//  CountriesNetworkService.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 07/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import Alamofire

fileprivate struct Constant {
    
    static let mainUrl = "https://restcountries.eu/rest/v2/all"
}

class CountriesNetworkService: RequestServiceTypeForAlamofire {

    private let model = ArrayModel(values: [Country]())
    private let parser = ParserCountry()
    private var databaseCountry: CountriesDatabaseServiceProtocol
    
    init(databaseCountry: CountriesDatabaseServiceProtocol) {
        self.databaseCountry = databaseCountry
    }
    
    public func getCountries(_ countrys: ArrayModel<Country>, completion: @escaping Closure.Execute<[Country]?>) -> NetworkTask?  {
        let urlCountry = URL(string: Constant.mainUrl)
        
        return urlCountry.map { 
            requestData(url: $0) {  dataResult in
                _ =  dataResult.map { 
                    let countries =  self.parser.convert(data: $0!) //TODO: remove force unwrap
                        .analysis(
                            success: { 
                                countrys.addAll(values: $0)
                                return self.success(countries: $0)
                            }, 
                            failure: { _ in self.databaseCountry.loadCities() } 
                        )
                    
                    completion(countries)
                }
            }
        }
    }
    
    func success(countries: [Country]) -> [Country] {
        self.databaseCountry.save(countries: countries)
        return countries
    }
}

