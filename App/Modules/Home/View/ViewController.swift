//
//  ViewController.swift
//  WeatherAppLC
//
//  Created by u633168 on 30/01/2023.
//

import UIKit

protocol HomeDelegate{
    func reloadTable()
    func showError(error: String)
}


class ViewController: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    
    
    private var viewModel: HomeViewModel?
     
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
            
        
        self.viewModel = HomeViewModel(delegate: self)
        self.viewModel?.getClimaCiudades()
        
        
        print(self.viewModel?.getClima(at: 0),"climaciudades viwcnroller")
    }


}
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
//       let clima = self.viewModel?.getClima(at: indexPath.row)

        cell.textLabel?.text = "String((clima?.main.temp)!)"
        return cell
    }
    
    
}

//extension ViewController : UITableViewDelegate{
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//
//}
//extension ViewController : UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.viewModel?.getClimasCount() ?? 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
//        let clima = self.viewModel?.getClima(at: indexPath.row)
//
//        cell?.textLabel?.text = String((clima?.main.temp)!)

//        return cell!
//    }
//
//
//}

extension ViewController : HomeDelegate{
    func reloadTable() {
        self.tableView.reloadData()
    }
    
    func showError(error: String) {
        print("algo fallo,", error)
    }
    
    
}
