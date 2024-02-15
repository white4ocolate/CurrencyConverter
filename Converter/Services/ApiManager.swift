//
//  ApiManageer.swift
//  Converter
//
//  Created by white4ocolate on 12.02.2024.
//

import Foundation

class ApiManager {
    
    var currentCurrencies:[Currencies] = []
    var onCompletion: (([Currencies]) -> ())?
    
    public func fetchCurrentCurrencies() {
        let urlString = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data  else { return }
            guard let currencies = self.parseJSON(withData: data) else { return }
            for currency in currencies {
                self.currentCurrencies.append(currency)
            }
            self.onCompletion?(self.currentCurrencies)
        }
        task.resume()
    }
    
    private func parseJSON(withData data: Data) -> [Currencies]? {
        let decoder = JSONDecoder()
        do {
            let currencies: [Currencies] = try decoder.decode([Currencies].self, from: data)
            return currencies
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
