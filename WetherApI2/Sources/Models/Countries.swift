//
//  Countries.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Countries {
    public var values = [Country]() 
    public var model = ModelManager.shared
    
    private var parser = NetworkManager<[Country]>()
    private var parserWether = NetworkManager<Weather>()
    
    func persingCountryAPI() {
      
        let jsonUrl = "https://restcountries.eu/rest/v2/all"
        guard let url = URL(string: jsonUrl) else 
        { return }
        self.parser.requestData(url: url)
        let observer = self.parser.observer { state, _ in
            switch state {
            case .notWorking:
                return
            case .didStartLoading:
                return
            case .didLoad:
                //self.model = Countries(countries: self.parserCountries.model!)
                self.model.countries = self.parser.model!
            case .didFailedWithError(_):
                return
            }
        }
    }
    
}



