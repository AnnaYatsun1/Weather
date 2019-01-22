//
//  CityCellCollectionViewCell.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class CityCellCollectionViewCell: UITableViewCell {

    @IBOutlet var cityLabel: UILabel?
    @IBOutlet var countryLable: UILabel?
    @IBOutlet var temperature: UILabel?
    @IBOutlet var data: UILabel?
    
    public func fill(country: Country) {
        self.countryLable?.text = country.name
        self.cityLabel?.text = country.capital
        self.temperature?.text = country.weather?.main?.temperature.debugDescription
//        self.data?.text = country.weather?.main?.temperature?.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
