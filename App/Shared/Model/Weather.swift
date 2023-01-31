//
//  Weather.swift
//  WeatherAppLC
//
//  Created by u633168 on 30/01/2023.
//

import Foundation

// MARK: - Weather
struct Weather: Decodable {
    let main: Main
    let name : String
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
