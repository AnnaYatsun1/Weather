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
      
    public func getCountries(_ countrys: ArrayModel<Country>) -> NetworkTask?  {
        let urlCountry = URL(string: Constant.mainUrl)
        return  urlCountry.map { //TODO: Move to function
            requestData(url: $0) { 
                $0.map { data in 
                    data.do { data in 
                        self.parser.convert(data: data)
                            .analysis(
                            success: { couuntry in
                                countrys.addAll(values: couuntry)
                                couuntry.forEach { country in 
                                    let countris = CountryRLM(name: country.name, capital: country.capital, id: country.id)
                                    self.databaseCountry.save(object: countris)
                                    }
                            }, 
                            failure: { _ in 
                                    _  = self.databaseCountry.getObjects(type: CountryRLM.self).map { contries in 
                                        contries.forEach { country in
                                            Country(name: country.name!, capital: country.capital!, id: country.id)
                                            
                                    }
                                }
                            }
                        )
                    }
                }
            }
        }
    }
}
