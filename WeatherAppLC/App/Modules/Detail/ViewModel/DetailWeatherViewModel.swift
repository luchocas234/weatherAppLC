//
//  DetailWeatherViewModel.swift
//  WeatherAppLC
//
//  Created by u633168 on 01/02/2023.
//

import Foundation
class DetailWeatherViewModel{

    var refreshData = { () -> () in }
    // Referencia al delegate del viewcontroller
    private var delegate: DetailDelegate

    // Array de Climas en el contexto del viewmodel

    var climaCiudades5days : Weather5Days?
    var listaWeather = [List](){
        didSet{
//
        }
    }

    var climaActual : WeatherModel?

    // Inicializador de la clase del viewmodel
    init( delegate: DetailDelegate){

        self.delegate = delegate

    }

    // Funcion principal para hacer la llamada de la api y obtener climas de ciudades
    

    // Obtener un clima en especifico en base a su indice dentro del array
    

    // Obtener la cantidad
    func getClimasCount() -> Int {
        return (climaCiudades5days?.list.count ?? 0)
    }

    

    func getClimaCiudades5days(city: String){

       
                NetWorkingController.get5daysWeather(cityName: city) { result in
                    switch result {
                    case .success( let climaCity5days):
                        self.climaCiudades5days = climaCity5days
                        self.listaWeather = climaCity5days.list
                        self.delegate.reloadTable()
                        
                        
                    case.failure(let error):
                        print(error)
                    }
                }
            
        
    }

    func getClima(at index: Int) -> List {
        return (climaCiudades5days?.list[index])!
    }


}
