//
//  ViewController.swift
//  WeatherAppLC
//
//  Created by u633168 on 30/01/2023.
//

import UIKit
import CoreLocation

protocol HomeDelegate{
    func reloadTable()
    func showError(error: String)
}


class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelClimaActual: UILabel!
    @IBOutlet weak var labelCityActual: UILabel!
    @IBOutlet weak var indicatorActv: UIActivityIndicatorView!
    
    @IBOutlet weak var imageViewWeathe: UIImageView!
    @IBOutlet weak var labelMax: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelMin: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let locationManager = CLLocationManager()
    private var viewModel: HomeViewModel?
    var lat = Double()
    var lon = Double()
     
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
        indicatorActv.startAnimating()
        
        self.viewModel = HomeViewModel(delegate: self)
        self.viewModel?.getClimaCiudades()
        self.viewModel?.getClimaCiudades5days()
        
        
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async{
            if(CLLocationManager.locationServicesEnabled()){
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.startUpdatingLocation()
            }
        }
        
//        self.viewModel?.getClimaLatLong(lat: -58.3772, long: -34.6132)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        
        self.viewModel?.getClimaLatLong(lat: lat, long: lon)
    }
    
   
    
    @IBAction func verMasAction(_ sender: Any) {
        let story = UIStoryboard(name: "DetailWeather", bundle: nil)
        let storyboard = story.instantiateViewController(withIdentifier: "DetailWeather") as! DetailWeatherViewController
        
        storyboard.climaActual = viewModel?.climaActual
        
        self.navigationController?.pushViewController(storyboard, animated: true)
        
    }
    
    
    
    
    
    
}
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.getClimasCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        guard let clima = self.viewModel?.getClima(at: indexPath.row) else {return cell}
        let temperature = clima.main.temp
        cell.textLabel?.text = String(format: "%.0f", temperature - 273.15)+"° C"
        cell.detailTextLabel?.text = clima.name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "DetailWeather", bundle: nil)
        let storyboard = story.instantiateViewController(withIdentifier: "DetailWeather") as! DetailWeatherViewController
//        guard let clima5days = self.viewModel?.getClima5daysIndex(at: indexPath.row) else{ return}
//        storyboard.clima5days = clima5days
        guard let clima = self.viewModel?.getClima(at: indexPath.row) else {return }
        storyboard.climaActual = clima
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "DetailWeather", bundle: nil)
        let storyboard = story.instantiateViewController(withIdentifier: "DetailWeather") as! DetailWeatherViewController
//        guard let clima5days = self.viewModel?.getClima5daysIndex(at: indexPath.row) else{ return}
//        storyboard.clima5days = clima5days
        guard let clima = self.viewModel?.getClima(at: indexPath.row) else {return }
        storyboard.climaActual = clima
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
}

extension ViewController : HomeDelegate{
    func reloadTable() {
        let formatter = DateFormatter()
             formatter.dateFormat = "dd MMM yyyy" //yyyy
        let stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(viewModel?.climaActual?.dt ?? 0)))
     DispatchQueue.main.async {
            
        let temperature = self.viewModel?.climaActual?.main.temp ?? 0
         let minTemp = self.viewModel?.climaActual?.main.tempMin ?? 0
         let maxTemp = self.viewModel?.climaActual?.main.tempMax ?? 0
         self.labelCityActual.text = self.viewModel?.climaActual?.name
         self.labelClimaActual.text = String(format: "%.0f", temperature - 273.15)+"° C"
         self.labelDate.text = stringDate
         self.labelDescription.text = self.viewModel?.climaActual?.weather[0].description
         self.labelMin.text = "Min: " + String(format: "%.0f", minTemp - 273.15)+"° C"
         self.labelMax.text = "Max: " + String(format: "%.0f", maxTemp - 273.15)+"° C"
         self.imageViewWeathe.image = UIImage(named: self.viewModel?.climaActual?.weather[0].icon ?? "default")
         
         
         self.labelDate.isHidden = false
         self.labelDescription.isHidden = false
         self.labelMin.isHidden = false
         self.labelMax.isHidden = false
         self.labelClimaActual.isHidden = false
         self.labelCityActual.isHidden = false
         self.imageViewWeathe.isHidden = false
         
         self.tableView.reloadData()
         self.indicatorActv.stopAnimating()
         self.indicatorActv.isHidden = true
        }
        
       
    }
    
    func showError(error: String) {
        print("algo fallo,", error)
    }
    
    
}
