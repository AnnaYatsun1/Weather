//
//  WeatherAPI.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 17/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

struct WeatherAPI: Decodable {
    public enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case dt
        case sys
        case id
        case name
        case cod
    }
    
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let id: Int
    let name: String
    let cod: Int

}
extension WeatherAPI {
    struct Clouds: Decodable {
        let all: Int
    }
}

extension WeatherAPI {
    struct Coord: Decodable {
        let lon, lat: Double
    }
}
extension WeatherAPI {
    struct Main: Decodable {
        let temp: Double
        let pressure: Int
        let  humidity: Int
        let tempMax: Double
        let tempMin: Double
        
        enum CodingKeys: String, CodingKey {
            case temp
            case pressure
            case humidity
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
}

extension WeatherAPI {
    struct Sys: Decodable {
        public enum CodingKeys: String, CodingKey {
            case type
            case id
            case message
            case country
            case sunrise
            case sunset
        }
        
        let type: Int
        let id: Int
        let message: Double
        let country: String
        let sunrise: Int
        let sunset: Int
    }
}
extension WeatherAPI {
    struct Weather: Decodable {
        public enum CodingKeys: String, CodingKey {
            case id
            case main
            case description
            case icon
        }
        let id: Int
        let main: String
        let description: String 
        let icon: String
    }
}

extension WeatherAPI {
    struct Wind: Decodable {
        let speed: Double
        let deg: Int
    }
}
