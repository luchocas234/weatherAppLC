//
//  DetailWeatherViewController.swift
//  WeatherAppLC
//
//  Created by u633168 on 01/02/2023.
//

import UIKit

protocol DetailDelegate {
  
        func reloadTable()
        func showError(error: String)
    
}

class DetailWeatherViewController: UIViewController {

    var climaActual: WeatherModel?
    var clima5days : Weather5Days?
    
    @IBOutlet weak var imageDetail: UIImageView!
    private var viewModel: DetailWeatherViewModel?
    @IBOutlet weak var cityDetailLabel: UILabel!
    @IBOutlet weak var tempDetailActual: UILabel!
    
    @IBOutlet weak var indicatorActv: UIActivityIndicatorView!
    @IBOutlet weak var detailTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTable.delegate = self
        detailTable.dataSource = self
        self.viewModel = DetailWeatherViewModel(delegate: self)
        let nameCity = climaActual!.name.replacingOccurrences(of: " ", with: "+")
        self.viewModel?.getClimaCiudades5days(city: nameCity)
        indicatorActv.startAnimating()
    }
    


}
extension DetailWeatherViewController : DetailDelegate{
    func reloadTable() {
//        print(self.viewModel?.climaCiudades5days,"PRINT DETALLE")
        let temperature = climaActual!.main.temp
        DispatchQueue.main.async {
            self.tempDetailActual.text = String(format: "%.0f", temperature - 273.15)+"° C"
            self.cityDetailLabel.text = self.climaActual?.name
            
            self.tempDetailActual.isHidden = false
            self.cityDetailLabel.isHidden = false
            self.imageDetail.image = UIImage(named: self.climaActual!.weather[0].icon)
            self.detailTable.reloadData()
            self.indicatorActv.stopAnimating()
            self.indicatorActv.isHidden = true
        }
        
    }
    
    func showError(error: String) {
        
    }
    
    
}

extension DetailWeatherViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.getClimasCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath) as! WeatherTableViewCell
        
        guard let clima = self.viewModel?.getClima(at: indexPath.row) else{return cell}
        let temperature = clima.main.temp
        
        
        cell.tempLabelCell.text = String(format: "%.0f", temperature - 273.15)+"° C"
        
        let formatter = DateFormatter()
             formatter.dateFormat = "EEEE dd-MM HH:mm" //yyyy
        let stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(clima.dt )))
        
        cell.dateLabelCell.text = stringDate
        
        cell.minLabelCell.text = String(format: "%.0f", clima.main.tempMin - 273.15)+"° C"
        cell.maxLabelCell.text = String(format: "%.0f", clima.main.tempMax - 273.15)+"° C"
        
        cell.imageCell.image = UIImage(named: clima.weather[0].icon )
        
        return cell
    }
    
    
}

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var tempLabelCell: UILabel!
    @IBOutlet weak var maxLabelCell: UILabel!
    @IBOutlet weak var minLabelCell: UILabel!
    @IBOutlet weak var dateLabelCell: UILabel!
}
