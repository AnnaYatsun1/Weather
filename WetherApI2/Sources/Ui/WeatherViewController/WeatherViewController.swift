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
    
    private var wrappedCity: Model<Country>
    private var observer: Cancellable?
    private var weatherManeger: WeatherNetworkService
    
    deinit { print("\(self) deinit") }
    
    init(city: Model<Country>, weatherManeger: WeatherNetworkService) {
        self.wrappedCity = city
        self.weatherManeger = weatherManeger
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherManeger.getWeather(country: self.wrappedCity.value) { weather in 
            self.wrappedCity.modify {
                $0.weather = weather
                
            }
            
            self.updateUI()
        }
    }
            
    private func updateUI() {
      dispatchOnMain {
            self.rootView?.fill(with: self.wrappedCity)
        }
    }
}
