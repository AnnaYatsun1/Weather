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
    private var wetherManeger: WeatherNetworkService
    
    deinit { print("\(self) deinit") }
    
    init(city: Model<Country>, wetherManeger: WeatherNetworkService) {
        self.wrappedCity = city
        self.wetherManeger = wetherManeger
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let country = self.wrappedCity.value
        self.wetherManeger.getWeather(country: country) { weather in 
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
