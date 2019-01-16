//
//  Weather.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

final class Weather: Decodable  {

    
 
    enum CodingKeys: String, CodingKey {
        case main = "main"
    }
    
    private(set) var main: Main?    
    
    class Main: Decodable {
        var delegate: ModelDelegateWeather?
        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
        }
        
        public var temperature: Double? = nil {
            didSet {
                self.delegate?.update()
            }
        }
        
    }
    

    
    
//    func persingWeatherAPI() {  
//    
//        let jsonUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + self.capital! + "&units=metric&APPID=497c896b2c9814f2e7c9508a4c7ba762"
//        let convertUrl = jsonUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        
//        guard let url = URL(string: convertUrl!) else 
//        { return }
//        self.parser.requestData(url: url)
//        let observer = self.parser.observer { state, _ in
//            switch state {
//            case .notWorking: return
//            case .didStartLoading: return
//            case .didLoad:
//    
//                let country = self.model.takeCountry(by: self.capital!)
//                country?.temperature = self.parser.model?.main?.temperature
//                
//            case .didFailedWithError: return
//            }
//        }
//    }
}
