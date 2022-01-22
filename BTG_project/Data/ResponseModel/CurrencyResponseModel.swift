//
//  CurrencyResponseModel.swift
//  BTG_project
//
//  Created by matheus.s.franca on 23/08/21.
//

import Foundation

class CurrencyResponseModel: Codable {
    var success: Bool?
    var currencies: [String: String]?
}

class DolarQuotesResponseModel: Codable {
    var success: Bool?
    var source: String?
    var quotes: [String: Double]?
}
