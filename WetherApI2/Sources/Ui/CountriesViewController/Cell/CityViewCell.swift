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
        self.cityLabel?.text = country.name
        self.countryLable?.text = country.country
        self.temperature?.text = country.weather?.temperature.debugDescription
        self.data?.text = country.weather?.timestamp.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
