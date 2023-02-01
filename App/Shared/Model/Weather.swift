//
//  Weather.swift
//  WeatherAppLC
//
//  Created by u633168 on 30/01/2023.
//

import Foundation

// MARK: - Weather
struct WeatherModel: Decodable {
    let main: Main
    let name : String
    let weather: [Weather]
//    let sys: Sys
    let dt: Int
    let timezone: Int?
    let dt_txt: String?
}

// MARK: - Main
struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
       
    
    }
}
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
//struct Sys: Codable {
//    let country: String?
//    let sunrise: Int?
//    let sunset: Int?
//}

   
