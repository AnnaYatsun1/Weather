//
//  WeatherManager.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 21/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class WeatherManager {
    public var completion: Completion<Weathers>?
    
   private(set) var weather: Weathers?
    private let parserWeather = NetworkManager<Weathers>()
    
    init() {
        self.subscribe()
    }
    
    public func parsWeather(capital: String) {
        let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + capital + "&units=metric&APPID=497c896b2c9814f2e7c9508a4c7ba762"
        let convertUrl = baseUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        convertUrl
            .flatMap(URL.init)
            .do(self.parserWeather.requestData)
    }
    
    private func subscribe() {
        _ = self.parserWeather.observer { state, _  in
            switch state {
            case .didStartLoading: return
            case .didLoad:
                self.parserWeather.model.do { weather in
                self.weather = weather
                    self.completion?(weather)
                }
            case .didFailedWithError: return
            case .notWorking:
                return
            }
        }
    }
}
