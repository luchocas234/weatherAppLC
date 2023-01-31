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
    
//    "q={city name}&appid={API key}"
    private static let apiKey = "b7bbc01e704029ade2b475cc70c5eecb"
    
    //        enum Endpoint {
    //            case cityId(path: String = "/data/2.5/weather", id: Int)
    //            case cityName(path: String = "/data/2.5/weather", name: String)
    //
    //            var url: URL? {
    //                var components = URLComponents()
    //
    //                components.scheme = "https"
    //                components.host = baseUrl
    //                components.path = path
    //                components.queryItems = queryItems
    //
    //                return components.url
    //            }
    //
    //            private var path: String {
    //                switch self {
    //                case .cityId(let path, _):
    //                    return path
    //                case .cityName(let path, _):
    //                    return path
    //                }
    //            }
    //
    //            private var queryItems: [URLQueryItem] {
    //
    //                var queryItems = [URLQueryItem]()
    //
    //                switch self {
    //                case .cityId(_, let id):
    //                    queryItems.append(URLQueryItem(name: "id", value: String(id)))
    //                case .cityName(_, name: let name):
    //                    queryItems.append(URLQueryItem(name: "q", value: name))
    //                }
    //
    //
    //                queryItems.append(URLQueryItem(name: "appid", value: apiKey))
    //
    //                return queryItems
    //            }
    //        }
    //
    //        // 5128581 is New York
    //        static func fetchWeather(for cityId: Int, _ completion: @escaping ((Weather) -> Void)) {
    //            if let url = Endpoint.cityId(id: cityId).url {
    //                URLSession.shared.dataTask(with: url) { (data, response, error) in
    //                    if let error = error {
    //                        print("Ocurrio un error!", error)
    //                    }
    //
    //                    if let data = data {
    //                        do {
    //                            let weather = try JSONDecoder().decode(Weather.self, from: data)
    //                            completion(weather)
    //                        } catch let error {
    //                            print("Error al decodear objeto...", error)
    //                        }
    //
    //                    }
    //                }.resume()
    //            }
    //        }
    //
    //    static func fetchWeatherByCityName(for cityName: String, _ completion: @escaping ((Weather) -> Void)) {
    //
    //        if let url = Endpoint.cityName(name: cityName).url {
    //            URLSession.shared.dataTask(with: url) { (data, response, error) in
    //                if let error = error {
    //                    print("Ocurrio un error!", error)
    //                }
    //
    //                if let data = data {
    //                    do {
    //                        let weather = try JSONDecoder().decode(Weather.self, from: data)
    //                        completion(weather)
    //                    } catch let error {
    //                        print("Error al decodear objeto...", error)
    //                    }
    //
    //                }
    //            }.resume()
    //        }
    //    }
    //
    //
    
    static func getWeather(cityName: String, completion: @escaping (Result <[Weather],Error>) -> Void) {

        let url = "\(NetWorkingController.baseUrl2)q=\(cityName)&appid=\(NetWorkingController.apiKey)"
        
        AF.request(url, method: .get).responseDecodable (of: Weather.self) {  response in
            
            if let weather = response.value {
                completion(.success([weather]))
            } else {
                completion(.failure(response.error!))
            }
        }
    }
    
    
}
