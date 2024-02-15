//
//  ViewController.swift
//  Converter
//
//  Created by white4ocolate on 12.02.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var curenciesArray = [Currencies]()
    var apiManager = ApiManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        tableView.dataSource = self
        apiManager.fetchCurrentCurrencies() 
        
        apiManager.onCompletion = { [weak self] currencies in
            guard let self else { return }
            self.updateTableView(with: currencies)
        }
    }
    
    private func updateTableView(with currencies: [Currencies]) {
        DispatchQueue.main.async{
            self.activityIndicator.isHidden = true
            
            self.curenciesArray = currencies
            self.tableView.reloadData()
        }
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return curenciesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "currencies", for: indexPath) as? CustomTableViewCell else {
            fatalError("Error with CustomCell")
        }
        cell.configuration(curencies: curenciesArray, indexPath: indexPath)
        
        return cell
    }
}
