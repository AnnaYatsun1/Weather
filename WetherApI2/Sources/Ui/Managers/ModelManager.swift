//
//  ModelManager.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class ModelManager: ObservableObject<ModelManager.State> {
    public enum State {
        case tookIntoObservation
        case notTookIntoObservation
        case needToUpdate
    }
    
    static let shared = ModelManager(countries: [Country]() )
    
    private(set) var state: State = .notTookIntoObservation {
        didSet {
            self.notify(new: self.state)
        }
    }
    
    public var countries: [Country] {
        didSet {
            self.notify(new: .needToUpdate)
        }    
    }
    
    private init(countries: [Country]) {
        self.countries = countries
    }
    
    func takeCountry(by capital: String) -> Country?  {
        return countries.first(where: {

            $0.capital == capital 
        })
    }
}
