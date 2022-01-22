//
//  UserDefaults.swift
//  BTG_project
//
//  Created by matheus.s.franca on 23/08/21.
//

import Foundation

extension UserDefaults{
    
    //MARK: Save Currency List
    func setCurrencyList(value: [CurrencyModel]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey:  UserDefaultsKeys.currencyList.rawValue)
        }
    }
    
    //MARK: Retrieve Currency List
    func getCurrencyList() -> [CurrencyModel]? {
        if let objects = UserDefaults.standard.value(forKey: UserDefaultsKeys.currencyList.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [CurrencyModel] {
                return objectsDecoded
            } else {
                return []
            }
        } else {
            return []
        }
    }
    
    //MARK: Save USD Quotes List
    func setUSDQuotes(value: [DolarQuotesModel]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey:  UserDefaultsKeys.USDQuotes.rawValue)
        }
    }
    
    //MARK: Retrieve USD Quotes List
    func getUSDQuotes() -> [DolarQuotesModel]? {
        if let objects = UserDefaults.standard.value(forKey: UserDefaultsKeys.USDQuotes.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [DolarQuotesModel] {
                return objectsDecoded
            } else {
                return []
            }
        } else {
            return []
        }
    }
}


enum UserDefaultsKeys : String {
    case currencyList
    case USDQuotes
}
