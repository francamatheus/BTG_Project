//
//  DolarQuotesModel.swift
//  BTG_project
//
//  Created by matheus.s.franca on 23/08/21.
//

import Foundation

class DolarQuotesModel: Codable {
    var initials: String?
    var quote: Double?
    
    init(initials: String?, quote: Double?) {
        self.initials = initials
        self.quote = quote
    }
    
    // MARK: - Mapping
    static func mapFrom(response: DolarQuotesResponseModel?) -> [DolarQuotesModel] {
        var dolarQuotesList: [DolarQuotesModel] = []
        
        response?.quotes?.forEach({ (initials, quote) in
            dolarQuotesList.append(DolarQuotesModel(initials: initials, quote: quote))
        })
        
        return dolarQuotesList
    }
}
