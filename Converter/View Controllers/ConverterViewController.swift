//
//  ConverterViewController.swift
//  Converter
//
//  Created by white4ocolate on 13.02.2024.
//

import UIKit

class ConverterViewController: UIViewController, UIPickerViewDelegate {
    
    var currencyNames: [String] = []
    var currencyRates: [Double] = []
    var apiManager = ApiManager()
    var activeCurrency = 0.0
    var isUAHActive = false
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyRate: UITextField!
    @IBOutlet weak var uahRate: UITextField!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        
        apiManager.fetchCurrentCurrencies()
        apiManager.onCompletion = { [weak self] currencies in
            DispatchQueue.main.sync{
                guard let self else {return}
                for currency in currencies {
                    self.currencyNames.append(currency.name)
                    self.currencyRates.append(currency.rate)
                }
                self.currencyPicker.reloadAllComponents()
                self.currencyLabel.text = self.currencyNames.first
                self.activeCurrency = self.currencyRates.first ?? 0.0
            }
        }
        currencyRate.addTarget(self, action: #selector(updateRate), for: .editingChanged)
        uahRate.addTarget(self, action: #selector(updateUAHRate), for: .editingChanged)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard)))
    }
    
    @objc private func hideKeyBoard(){
        self.view.endEditing(true)
    }
    
    @objc func updateRate(input: Double) {
        guard let amountText = currencyRate.text, let amount = Double(amountText) else {return}
        if currencyRate.text != "" {
            let total = amount * activeCurrency
            uahRate.text = String(format: "%.2f", total)
        }
        self.isUAHActive = false
    }
    @objc func updateUAHRate(input: Double) {
        guard let amountText = uahRate.text, let amount = Double(amountText) else {return}
        if uahRate.text != "" {
            let total = amount / activeCurrency
            currencyRate.text = String(format: "%.2f", total)
        }
        self.isUAHActive = true
    }
}

