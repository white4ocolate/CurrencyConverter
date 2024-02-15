//
//  CustomTableViewCell.swift
//  Converter
//
//  Created by white4ocolate on 13.02.2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!

    public func configuration(curencies: [Currencies], indexPath: IndexPath){
        self.nameLabel.text = curencies[indexPath.row].name
        self.rateLabel.text = curencies[indexPath.row].rateString
    }
}
