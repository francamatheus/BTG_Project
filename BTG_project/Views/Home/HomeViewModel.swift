//
//  HomeViewModel.swift
//  BTG_project
//
//  Created by matheus.s.franca on 23/08/21.
//

import Foundation
import RxSwift

protocol CurrencyDelegate: AnyObject {
    func onOriginCurrencySelected(currency: String)
    func onDestinyCurrencySelected(currency: String)
}

class HomeViewModel {
    var dolarQuotesList: [DolarQuotesModel] = []
        
    let disposeBag = DisposeBag()
    let service = CurrenciesService()
    
    var isConnected = true
    
    var convertedValue = ""
    
    func fetchList(originCurrency: String,
                   destinyCurrency: String,
                   value: Double,
                   success: @escaping () -> Void,
                   error: @escaping (String) -> Void) {
        
        if !Reachability.isConnectedToNetwork() {
            if let list = UserDefaults.standard.getUSDQuotes(), !list.isEmpty {
                isConnected = false
                self.dolarQuotesList = list
                self.convertQuotes(originCurrency: originCurrency, destinyCurrency: destinyCurrency, value: value)
                success()
                return
            }
        }
        
        service.getDolarQuotes().subscribe(onSuccess: { [weak self] response in
            self?.dolarQuotesList = DolarQuotesModel.mapFrom(response: response)
            self?.convertQuotes(originCurrency: originCurrency, destinyCurrency: destinyCurrency, value: value)
            UserDefaults.standard.setUSDQuotes(value: self?.dolarQuotesList ?? [])
            self?.isConnected = true
            success()
        }, onError: { errorResponse in
            if let generalError = errorResponse as? GeneralError {
                error(generalError.status ?? "Unknown Error")
            } else {
                error(errorResponse.localizedDescription)
            }
        }).disposed(by: disposeBag)
    }
    
    func convertQuotes(originCurrency: String,
                       destinyCurrency: String,
                       value: Double) {
        
        let originCurrencyUSD = findUSDCurrency(currency: originCurrency)
        let destinyCurrencyUSD = findUSDCurrency(currency: destinyCurrency)
        
        let convertedDoubleValue = (destinyCurrencyUSD * value) / originCurrencyUSD
        
        convertedValue = String(convertedDoubleValue.rounded(toPlaces: 2))
    }
    
    func findUSDCurrency(currency: String) -> Double {
        var usdCurrency: Double = 0
        dolarQuotesList.forEach { (value) in
            if (value.initials?.contains(currency) ?? false && currency != "USD") {
                usdCurrency = value.quote ?? 0
            } else if currency == "USD" {
                usdCurrency = 1
            }
        }
        return usdCurrency
    }
}
