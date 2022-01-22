//
//  Currencies.swift
//  BTG_project
//
//  Created by matheus.s.franca on 23/08/21.
//

import Foundation
import Moya
import RxSwift

/// Requests related to the user's account
struct CurrenciesService {
    
    let provider = MoyaProvider<BTG>()
    
    func getCurrencies() -> Single<CurrencyResponseModel?> {
        return provider.rx
            .request(.currencies)
            .flatMap { response -> Single<CurrencyResponseModel?> in
                if let responseType = try? response.map(CurrencyResponseModel.self) {
                    return Single.just(responseType)
                } else if let errorType = try? response.map(GeneralError.self) {
                    return Single.error(errorType)
                } else {
                    return Single.error(GeneralError(status: "Unknown Error", code: 000))
                }
            }
    }
    
    func getDolarQuotes() -> Single<DolarQuotesResponseModel?> {
        return provider.rx
            .request(.live)
            .flatMap { response -> Single<DolarQuotesResponseModel?> in
                if let responseType = try? response.map(DolarQuotesResponseModel.self) {
                    return Single.just(responseType)
                } else if let errorType = try? response.map(GeneralError.self) {
                    return Single.error(errorType)
                } else {
                    return Single.error(GeneralError(status: "Unknown Error", code: 000))
                }
            }
    }
}
