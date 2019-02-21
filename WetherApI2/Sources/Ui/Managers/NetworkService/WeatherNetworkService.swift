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

class WeatherNetworkService: RequestServiceTypeForAlamofire {
    
    private let parser = ParserWeather()
    private let databaseWeather = WeatherDatabaseService()
    
    public func getWeather(country: Country, completion: @escaping Closure.Execute<Weather?>) -> NetworkTask? {
        return self.getUrl(country: country).map { url in
            self.requestData(url: url) { dataResult in
                _ = dataResult.map { 
            
                    let weather = self.parser.convert(data: $0!).analysis(
                            success: { self.success(weather: $0, countries: country) },
                            failure: { _ in self.databaseWeather.loadWeather(country: country) }
                    )
                    completion(weather)
                }
            }
        }
    }    
    
    private func getUrl(country: Country) -> URL? {
        let capital = country.capital
        let convertUrl = capital.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let baseUrl = convertUrl.map { Constant.mainUrl + $0 + Constant.apiKey}
        let url = baseUrl.flatMap(URL.init)
        
        return url
    } 
    
    private func success(weather: Weather, countries: Country) -> Weather {
        self.databaseWeather.saveWeather(weather, country: countries)
        return weather
    }
}
