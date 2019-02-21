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
    private let databaseCountry = CountriesDatabaseService()
    public func getCountries(_ countrys: ArrayModel<Country>, completion: @escaping Closure.Execute<[Country]>) -> NetworkTask?  {

            let urlCountry = URL(string: Constant.mainUrl)
            return  urlCountry.map { 
                requestData(url: $0) {  dataResult in
                  _ =  dataResult.map { 
                                let parsed = self.parser.convert(data: $0!)
                    
                                let countries =  parsed.analysis(
                                    success: { couuntry in
                                        countrys.addAll(values: couuntry)
                                        self.save(countries: couuntry)
                                }, 
                                    failure: { _ in 
                                        _  = self.databaseCountry.getObjects(type: CountryRLM.self).map { contries in 
                                            contries.forEach { country in
                                               Country(countryRLM: country)
                                        }
                                    }
                                } 
                                
                            )
//                            completion(countries)
                        }
                    }
                }
            }
    private func save(countries: [Country]) -> () {
        countries.forEach { country in 
            let countris = CountryRLM(name: country.name, capital: country.capital, id: country.id)
            self.databaseCountry.save(object: countris)
        } 
    }
    
//    private func cached() -> [Country] {
//        return self.databaseCountry
//            .getObjects(type: CountryRLM.self)
//            .map {
//                $0.map{
//                    Country(countryRLM: $0)
//            }
//        }
//    }
}

