//
//  CityCellTableViewCell.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class CityCellTableViewCell: UITableViewCell {

    @IBOutlet var cityLabel: UILabel?
    @IBOutlet var countryLable: UILabel?
    @IBOutlet var temperature: UILabel?
    @IBOutlet var data: UILabel?


    
    public func fill(country:  Model<Country>) {
        self.countryLable?.text = country.value.name
        self.cityLabel?.text = country.value.capital
        self.temperature?.text = country.value.weather?.temperature?.description
//        self.data?.text = country.weather?.main?.temperature?.description
    }
    
    deinit {
//        print("cell deinit")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        print("cell init")
    }
}
