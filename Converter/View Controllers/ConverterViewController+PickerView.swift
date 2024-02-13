//
//  ConverterViewController+PickerView.swift
//  Converter
//
//  Created by white4ocolate on 13.02.2024.
//

import Foundation
import UIKit

extension ConverterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.activeCurrency = currencyRates[row]
        currencyLabel.text = currencyNames[row]
        if !isUAHActive {
            updateRate(input: self.activeCurrency)
        } else {
            updateUAHRate(input: self.activeCurrency)
        }
    }
}
