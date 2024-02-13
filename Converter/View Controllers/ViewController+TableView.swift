//
//  ViewController+TableView.swift
//  Converter
//
//  Created by white4ocolate on 13.02.2024.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return curenciesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencies", for: indexPath) as! CustomTableViewCell

        cell.nameLabel.text = curenciesArray[indexPath.row].name
        cell.rateLabel.text = curenciesArray[indexPath.row].rateString
        
        return cell
    }
}
