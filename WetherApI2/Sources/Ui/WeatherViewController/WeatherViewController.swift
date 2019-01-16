//
//  WeatherViewController.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, RootViewRepresentable {
    typealias RootView =  WeatherView
    private var parser = NetworkManager<Weather>()
//    private(set) var country = Countries()
   
    public var model = ModelManager.shared
    public var capital: String?
    var weather = Weather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.persingWeatherAPI()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.displayLable()
    }
    
    func displayLable() {
        DispatchQueue.main.async {
            self.rootView?.infoLabel?.text = self.capital ?? ""
            self.rootView?.temperatura?.text = self.parser.model?.main?.temperature?.description ?? "" 
        }
    }
    
    func persingWeatherAPI() {  
        let jsonUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + self.capital! + "&units=metric&APPID=497c896b2c9814f2e7c9508a4c7ba762"
        let convertUrl = jsonUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url = URL(string: convertUrl!) else 
        { return }
        self.parser.requestData(url: url)
        let observer = self.parser.observer { state, _ in
            switch state {
            case .notWorking: return
            case .didStartLoading: return
            case .didLoad:
                 self.displayLable()
                 let country = self.model.takeCountry(by: self.capital!)
                 country?.temperature = self.parser.model?.main?.temperature

            case .didFailedWithError: return
            }
        }
    }
}
