//
//  CurrencyModel.swift
//  BTG_project
//
//  Created by matheus.s.franca on 23/08/21.
//

import Foundation

class CurrencyModel: Codable {
    var name: String?
    var initials: String?
    
    init(name: String?, initials: String?) {
        self.initials = initials
        self.name = name
    }
    
    // MARK: - Mapping
    static func mapFrom(response: CurrencyResponseModel?) -> [CurrencyModel] {
        var currencyList: [CurrencyModel] = []
        
        response?.currencies?.forEach({ (initials, name) in
            currencyList.append(CurrencyModel(name: name, initials: initials))
        })
        
        let sortedList = currencyList.sorted(by: { $0.initials ?? "" < $1.initials ?? "" })
        
        return sortedList
    }
}
