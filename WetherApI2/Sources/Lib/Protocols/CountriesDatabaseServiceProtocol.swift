//
//  CountriesDatabaseServiceProtocol.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 21/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

protocol CountriesDatabaseServiceProtocol {
    func loadCities() -> [Country]?
    func save(countries: [Country])
}
