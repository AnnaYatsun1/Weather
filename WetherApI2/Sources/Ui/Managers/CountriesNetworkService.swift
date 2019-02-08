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

class CountriesNetworkService {
    
    private let requestService: RequestService
    private let model = ArrayModel(values: [Country]())
    
    private let parser = ParserCountry()
    
        init(requestService: RequestService) {
            self.requestService = requestService
        }
      
    public func getCountries(_ countrys: ArrayModel<Country>) {
        let urlCountry = URL(string: Constant.mainUrl)
        
        urlCountry.do { url in
            self.requestService.requestData(url: url) { data, error in
                let countries = self.parser.convert(data: data!)
                switch countries { 
                case .success(let country): 
                    //                        print(country.count)
                    countrys.addAll(values: country)
                case .error(let errors):  break
                }
            }
        }
    }
}
