//
//  ModelManager.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

typealias Completion<T> = (T) -> ()
class CountriesManager {
    
   public var completion: Completion<[Country]>?
    
    private var parserCountries = NetworkManager<[Country]>()
    let mainUrl = "https://restcountries.eu/rest/v2/all"
    
    init() {
        self.subscribe()
    }
    
    public func parsCountries() {
        let urlCountry = URL(string: self.mainUrl)
        
        urlCountry.do(self.parserCountries.requestData)
    }
    
    private func subscribe() {
        _ = self.parserCountries.observer { state, _ in
            switch state {
            case .didStartLoading: return
            case .didLoad:
                self.parserCountries.model.do { countries in
                    self.completion?(countries)
                }
            case .didFailedWithError: return
            case .notWorking:
                return
            }
        }
    }
}
