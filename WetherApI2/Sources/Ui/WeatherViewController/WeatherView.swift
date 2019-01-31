//
//  File.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

import UIKit

class WeatherView: UIView {
    
    @IBOutlet public var infoLabel: UILabel?
    @IBOutlet public var temperatura: UILabel?
    
    func fill(with model: Country) {
        self.infoLabel?.text = model.capital
        self.temperatura?.text = model.weather?.temperature?.description
    }
}
