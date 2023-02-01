//
//  UtilsFunctions.swift
//  WeatherAppLC
//
//  Created by u633168 on 31/01/2023.
//

import Foundation

//func calculateCelsius(fahrenheit: Double) -> Double {
//    var celsius: Double
//
//    celsius = (fahrenheit - 32) * 5 / 9
//
//    return celsius
//}

func convertToCelsius(fahrenheit: Double) -> Int {
    return Int(5.0 / 9.0 * (fahrenheit - 32.0))
}
