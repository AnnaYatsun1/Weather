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
    
    var country: Country?
    
    public func fill(country: Country?) {
        self.cityLabel?.text = country?.name
        self.countryLable?.text = country?.capital
        self.temperature?.text = country?.temperature?.description ?? ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
