//
//  WeatherNetworkService.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 07/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

fileprivate struct Constant {
    static let mainUrl = "https://api.openweathermap.org/data/2.5/weather?q="
    static let apiKey = "&units=metric&APPID=497c896b2c9814f2e7c9508a4c7ba762"
}


class WeatherNetworkService {
    
    private let requestService: RequestService
    
    private let parser = ParserWeather()
   
    
    init(requestService: RequestService) {
        self.requestService = requestService
    }
    
    public func getWeather(country: Country, completion: @escaping Closure.Execute<Weather>) {
        let capital = country.capital
        let convertUrl = capital!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let baseUrl = convertUrl.map { Constant.mainUrl + $0 + Constant.apiKey}
        
        baseUrl
            .flatMap(URL.init)
            .do { url in
            self.requestService.requestData(url: url) { data, error in
//                print(data)
               let weather = self.parser.convert(data: data!)
                // температура передала
//                print(" weathre in network \(weather)")
                switch weather {
                case .success(var weather):
//                    print("температура \(weather.temperature)")
                    country.weather = weather
                    completion(weather)
//                    print("температура2 ikjk;f \(weather.temperature) \(country.capital)")
                
                case .error(let error): break
                }
            }
        }
    }
}
