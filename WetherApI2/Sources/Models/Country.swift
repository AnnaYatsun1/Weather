//
//  Country.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Country: Decodable {

    let name: String
    let capital: String
    var temperature: Double?
}
