//
//  Currencies.swift
//  Converter
//
//  Created by white4ocolate on 12.02.2024.
//

import Foundation

struct Currencies: Decodable {
    var r030: Int
    var txt: String
    var rate: Double
    var rateString: String {
        return String(format: "%.2f", rate)
    }
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "cc"
        case rate
        case r030
        case txt
    }
}
