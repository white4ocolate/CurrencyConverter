//
//  Currencies.swift
//  Converter
//
//  Created by white4ocolate on 12.02.2024.
//

import Foundation

struct Currencies: Decodable {
    var id: Int
    var txt: String
    var rate: Double
    var name: String
    var rateString: String {
        return String(format: "%.2f", rate)
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "cc"
        case rate
        case id = "r030"
        case txt
    }
}
