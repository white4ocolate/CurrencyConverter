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
            guard let self else { return }
            self.updateUIConverter(with: currencies)
        }
        currencyRate.addTarget(self, action: #selector(updateRate), for: .editingChanged)
        uahRate.addTarget(self, action: #selector(updateUAHRate), for: .editingChanged)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard)))
    }
    
    private func updateUIConverter(with currencies: [Currencies]) {
        DispatchQueue.main.async{
            for currency in currencies {
                self.currencyNames.append(currency.name)
                self.currencyRates.append(currency.rate)
            }
            self.currencyPicker.reloadAllComponents()
            self.currencyLabel.text = self.currencyNames.first
            self.activeCurrency = self.currencyRates.first ?? 0.0
        }
    }
    
    @objc private func hideKeyBoard(){
        self.view.endEditing(true)
    }
    
    @objc private func updateRate(input: Double) {
        guard let amountText = currencyRate.text, let amount = Double(amountText) else { return }
        if !amountText.isEmpty {
            let total = amount * activeCurrency
            uahRate.text = String(format: "%.2f", total)
        }
        self.isUAHActive = false
    }
    
    @objc private func updateUAHRate(input: Double) {
        guard let amountText = uahRate.text, let amount = Double(amountText) else { return }
        if !amountText.isEmpty {
            let total = amount / activeCurrency
            currencyRate.text = String(format: "%.2f", total)
        }
        self.isUAHActive = true
    }
}
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
        isUAHActive ? updateUAHRate(input: self.activeCurrency) : updateRate(input: self.activeCurrency)
    }
}

