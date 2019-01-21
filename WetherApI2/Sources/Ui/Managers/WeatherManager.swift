//
//  WeatherManager.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 21/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class WeatherManager {
    let mainUrl = "https://api.openweathermap.org/data/2.5/weather?q="
    let apiKey = "&units=metric&APPID=60cf95f166563b524e17c7573b54d7e3"
    public var completion: Completion<Weather>?
    
    private(set) var weather: Weather?
    
    private let parserWeather = NetworkManager<Weather>()
    
    init() {
        self.subscribe()
    }
    
    public func parsWeather(capital: String) {
        let baseUrl = mainUrl + capital + apiKey
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
