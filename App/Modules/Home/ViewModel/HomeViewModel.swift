//
//  HomeViewModel.swift
//  WeatherAppLC
//
//  Created by u633168 on 31/01/2023.
//

import Foundation

class HomeViewModel{
    
    
    // Referencia al delegate del viewcontroller
    private var delegate: HomeDelegate
    
    // Array de pokemones en el contexto del viewmodel
    var climaCiudades = [Weather]()
    
    //    private var climaActual = [WeatherLocal]()
    
    // Inicializador de la clase del viewmodel
    init(delegate: HomeDelegate){
        
        self.delegate = delegate
    }
    
    // Funcion principal para hacer la llamada de la api y obtener climas de ciudades
    func getClimaCiudades(){
        let array = ["buenos%20aires","cordoba","mar%20del%20plata"]
        
        for city in array{
            
            NetWorkingController.getWeather(cityName: city) { result in
                switch result {
                case .success( let cities):
                    print(cities,"cities")
                    self.climaCiudades.append(contentsOf: cities)
                case.failure(let error):
                    print(error)
                }
                
            }

        }
        
    }
    
    // Obtener un pokemon en especifico en base a su indice dentro del array
    func getClima(at index: Int) -> [Weather] {
        return climaCiudades
    }
    
    // Obtener la cantidad de pokemones
    func getClimasCount() -> Int {
        climaCiudades.count
    }
    
   
}
