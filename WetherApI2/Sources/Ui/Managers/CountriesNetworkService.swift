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

class CountriesNetworkService: RequestService {

    private let model = ArrayModel(values: [Country]())
    private let parser = ParserCountry()
      
    public func getCountries(_ countrys: ArrayModel<Country>) -> NetworkTask?  {
        let urlCountry = URL(string: Constant.mainUrl)
        return  urlCountry.map { 
            requestData(url: $0) { 
                $0.map { data in 
                        self.parser.convert(data: data!)
                            .map { country in 
                                countrys.addAll(values: country)
                    }
                }
            }
        }
    }
}
