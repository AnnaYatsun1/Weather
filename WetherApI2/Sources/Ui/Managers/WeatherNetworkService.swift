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


class WeatherNetworkService: RequestServiceType {
    var task: URLSessionTask
    var isCancelled = false
    
    init(task: URLSessionTask) {
        self.task = task
    }
    private let parser = ParserWeather()
    
    public func getWeather(country: Country, completion: @escaping Closure.Execute<Weather>) {
        let capital = country.capital
        let convertUrl = capital!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let baseUrl = convertUrl.map { Constant.mainUrl + $0 + Constant.apiKey}
        
        baseUrl
            .flatMap(URL.init)
            .do  { url in 
            self.requestData(url: url) { (result: Result) in 
                result.map { data in 
                    self.parser.convert(data: data!)
                        .map { weather in 
                            country.weather? = weather
                            completion(weather)
                    }
                }
            }
        }
    }
    func cancel() {
        if self.task.state == .running {
            self.task.cancel()
        }
        self.isCancelled = true
    }
    
}
