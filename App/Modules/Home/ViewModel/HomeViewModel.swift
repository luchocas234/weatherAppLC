//
//  HomeViewModel.swift
//  WeatherAppLC
//
//  Created by u633168 on 31/01/2023.
//

import Foundation

class HomeViewModel{
    
    var refreshData = { () -> () in }
    // Referencia al delegate del viewcontroller
    private var delegate: HomeDelegate
    
    // Array de Climas en el contexto del viewmodel
    var climaCiudades = [WeatherModel](){
        didSet{
            self.delegate.reloadTable()
        }
    }
    var climaCiudades5days = [Weather5Days](){
        didSet{
            self.delegate.reloadTable()
        }
    }
    
    
    var climaActual : WeatherModel?
    
    // Inicializador de la clase del viewmodel
    init( delegate: HomeDelegate){
       
        self.delegate = delegate
        
    }
    
    // Funcion principal para hacer la llamada de la api y obtener climas de ciudades
    func getClimaCiudades(){
        
        let array = ["buenos%20aires","mendoza","mar%20del%20plata","san%20salvador%20de%20jujuy","rosario"]
        
        for city in array{
            DispatchQueue.main.async {
                NetWorkingController.getWeather(cityName: city) { result in
                    switch result {
                    case .success( let climaCity):
                        self.climaCiudades += [climaCity]
                    case.failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    // Obtener un clima en especifico en base a su indice dentro del array
    func getClima(at index: Int) -> WeatherModel {
        return climaCiudades[index]
    }
    
    // Obtener la cantidad
    func getClimasCount() -> Int {
        return climaCiudades.count
    }
    
    func getClimaLatLong(lat: Double, long:Double){
        DispatchQueue.main.async {
            NetWorkingController.getWeatherByCord(lat: lat, long: long) { result in
                switch result {
                case .success( let climaCity):
                    
                    self.climaActual = climaCity
                    self.delegate.reloadTable()
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getClimaCiudades5days(){
        
        let array = ["buenos%20aires","mendoza","mar%20del%20plata","san%20salvador%20de%20jujuy","rosario"]
        
        for city in array{
            DispatchQueue.main.async {
                NetWorkingController.get5daysWeather(cityName: city) { result in
                    switch result {
                    case .success( let climaCity5days):
                        self.climaCiudades5days += [climaCity5days]
                    case.failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    func getClima5daysIndex(at index: Int) -> Weather5Days {
        return climaCiudades5days[index]
    }
    
    
}
