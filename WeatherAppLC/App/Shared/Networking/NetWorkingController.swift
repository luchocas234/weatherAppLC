//
//  NetWorkingController.swift
//  WeatherAppLC
//
//  Created by u633168 on 30/01/2023.
//

import Foundation
import Alamofire

struct NetWorkingController{
    
    private static var baseUrl = "api.openweathermap.org"
    private let kStatusOk = 200...299;
    private static var baseUrl2 = "https://api.openweathermap.org/data/2.5/weather?"
    private static var baseUrlForecast = "https://api.openweathermap.org/data/2.5/forecast?"
    
//    "q={city name}&appid={API key}"
    private static let apiKey = "b7bbc01e704029ade2b475cc70c5eecb"
    
    
    
    static func getWeather(cityName: String, completion: @escaping (Result <WeatherModel,Error>) -> Void) {

        let url = "\(NetWorkingController.baseUrl2)q=\(cityName)&appid=\(NetWorkingController.apiKey)"
        
        AF.request(url, method: .get).responseDecodable (of: WeatherModel.self) {  response in
            
            if let weather = response.value {
                completion(.success(weather))
            } else {
                completion(.failure(response.error!))
            }
        }
    }
    
    static func getWeatherByCord(lat: Double, long: Double, completion: @escaping (Result <WeatherModel, Error>) -> Void) {
        let url = "\(NetWorkingController.baseUrl2)lat=\(lat)&lon=\(long)&appid=\(NetWorkingController.apiKey)"
        AF.request(url, method: .get).responseDecodable (of: WeatherModel.self) { response in
            if let weather = response.value{
                completion(.success(weather))
            }else {
                completion(.failure(response.error!))
            }
        }
    }
    
    static func get5daysWeather(cityName: String, completion: @escaping (Result <Weather5Days,Error>) -> Void){
        
        let url = "\(NetWorkingController.baseUrlForecast)q=\(cityName)&appid=\(NetWorkingController.apiKey)"
        
        AF.request(url, method: .get).responseDecodable (of: Weather5Days.self) {  response in
            
            if let weather = response.value {
                completion(.success(weather))
            } else {
                completion(.failure(response.error!))
            }
        }
        
        
    }
    
    
}
