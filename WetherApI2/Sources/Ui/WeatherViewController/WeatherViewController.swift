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
    
    private(set) var countriesManager = NetworkManager()
    
    deinit { print("\(self) deinit") }
    
    init(city: Model<Country>) {
        self.wrappedCity = city
        super.init(nibName: nil, bundle: nil)
//        print(city.value.weather?.temperature)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let country = self.wrappedCity.value
        country.capital.do { 
            self.countriesManager.loadWeather(capital: $0) { weather in 
                self.wrappedCity.modify {
                    $0.weather = weather
                }
                self.updateUI()             
            }
        }
    }
    
    private func updateUI() {
      dispatchOnMain {
            self.rootView?.fill(with: self.wrappedCity.value)
        }
    }
}
