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

    public let observer = CancellableObject()
    
    public func fill(country:  Model<Country>) {
        let country = country.value
        
        self.countryLable?.text = country.name
        self.cityLabel?.text = country.capital
        self.temperature?.text = country.weather?.temperature?.description
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
