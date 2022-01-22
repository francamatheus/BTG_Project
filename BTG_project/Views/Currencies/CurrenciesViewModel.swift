//
//  CurrenciesViewModel.swift
//  BTG_project
//
//  Created by matheus.s.franca on 23/08/21.
//

import Foundation
import RxSwift

class CurrenciesViewModel {
    var currencyList: [CurrencyModel] = []
    var filteredCurrencyList: [CurrencyModel] = []
        
    let disposeBag = DisposeBag()
    let service = CurrenciesService()
        
    func fetchList(success: @escaping () -> Void, error: @escaping (String) -> Void) {
        
        if !Reachability.isConnectedToNetwork() {
            if let list = UserDefaults.standard.getCurrencyList(), !list.isEmpty {
                self.currencyList = list
                self.filteredCurrencyList = list
                success()
                return
            }
        }

        
        service.getCurrencies().subscribe(onSuccess: { [weak self] response in
            self?.currencyList = CurrencyModel.mapFrom(response: response)
            self?.filteredCurrencyList = self?.currencyList ?? []
            UserDefaults.standard.setCurrencyList(value: self?.currencyList ?? [])
            success()
        }, onError: { errorResponse in
            if let generalError = errorResponse as? GeneralError {
                error(generalError.status ?? "Unknown Error")
            } else {
                error(errorResponse.localizedDescription)
            }
        }).disposed(by: disposeBag)
    }
    
    func currencies() -> [CurrencyModel] {
        return filteredCurrencyList
    }

    func currenciesCount() -> Int {
        return filteredCurrencyList.count
    }

    func currencyForIndex(_ index: Int) -> CurrencyModel {
        return filteredCurrencyList[index]
    }
    
    func filteredCurrencies(searchText: String) {
        var filteredData = currencyList
        if searchText.isEmpty == false {
            filteredData = currencyList.filter({ ($0.name?.contains(searchText) ?? false) })
        }
        filteredCurrencyList = filteredData
    }
}

