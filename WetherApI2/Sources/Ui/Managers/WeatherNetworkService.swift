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


class WeatherNetworkService: RequestService {
    private let parser = ParserWeather()
    
    public func getWeather(country: Country, completion: @escaping Closure.Execute<Weather>) -> NetworkTask? {
        let capital = country.capital
        let convertUrl = capital!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let baseUrl = convertUrl.map { Constant.mainUrl + $0 + Constant.apiKey}
        
       return baseUrl
            .flatMap(URL.init)
            .map { 
                self.requestData(url: $0) {
                    _ = $0.map { 
                        self.parser
                            .convert(data: $0!)
                            .map { 
                                country.weather = $0
                                completion($0)
                            }
                    }
                }
        }
    }    
}
