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

    public var capital: String?    
    public var weatherManager = WeatherManager()  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        
        self.weatherManager.completion = { weather in
            DispatchQueue.main.async {
//                self.rootView?.infoLabel?.text = self.weatherManager.parsWeather(capital: )
            }
        }
        
        self.weatherManager.parsWeather(capital: self.capital!)
    }
//    func displayLable() {
//        DispatchQueue.main.async {
//            self.rootView?.infoLabel?.text = self.capital ?? ""
//            self.rootView?.temperatura?.text = self.parser.model?.main?.temperature?.description ?? "" 
//        }
//    }
}
