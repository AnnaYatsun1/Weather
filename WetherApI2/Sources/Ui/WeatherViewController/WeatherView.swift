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
    var country: Country?
    
    public func fillInTheData(data: Weathers, city: String) {
        self.infoLabel?.text = city
        self.temperatura?.text = data.main?.temperature?.description

    }
}
