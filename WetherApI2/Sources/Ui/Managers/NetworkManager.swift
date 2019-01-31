//
//  ModelManager.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation


class NetworkManager {
    var requestService = RequestService()
    private var parserCountries = Parser<[CountryAPI]>()
    private var parserWeather = Parser<WeatherAPI>()
    let mainUrl = "https://restcountries.eu/rest/v2/all"

    public func loadCountries(completion: @escaping Closure.Execute<[Country]>) {
        self.requestService.make(url: mainUrl) { data in 
            self.parserCountries.decoder(from: data) { coutriesJson in
                var countries = [Country]()
                coutriesJson.do { 
                    countries = $0.map { 
                        Country(name: $0.name, capital: $0.capital)
                    }
                  
                }
                
                completion(countries)
            }
        }        
    }

    func loadWeather(capital: String, completion: @escaping Closure.Execute<Weather>) {
        let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + capital + "&units=metric&APPID=497c896b2c9814f2e7c9508a4c7ba762"
        let convertUrl = baseUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
     
        self.requestService.make(url: convertUrl!) { data in 
            self.parserWeather.decoder(from: data) { weatherJson in
                weatherJson.do {
                     completion(Weather(temperature: $0.main.temp))
                }
            }
        }
        
    }
}
