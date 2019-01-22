//
//  WeatherViewController.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, RootViewRepresentable {
    typealias RootView = WeatherView
    
    public var weatherManager = WeatherManager()
    public var city = "Default"
    
    public var completion: Completion<Weathers>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        
        self.weatherManager.completion = { weather in
            DispatchQueue.main.async {
                self.rootView?.fillInTheData(data: weather, city : self.city)
                self.completion?(weather)
            }
        }
        
        self.weatherManager.parsWeather(capital: self.city)
    }
    
}
