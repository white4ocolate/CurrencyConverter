//
//  ViewController.swift
//  Converter
//
//  Created by white4ocolate on 12.02.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var curenciesArray = [Currencies]()
    var apiManager = ApiManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        apiManager.fetchCurrentCurrencies() 
        
        apiManager.onCompletion = { [weak self] currencies in
            DispatchQueue.main.sync{
                guard let self else {return}
                self.curenciesArray = currencies
                self.tableView.reloadData()
            }
        }
    }
}
