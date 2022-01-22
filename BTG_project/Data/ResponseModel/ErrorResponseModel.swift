//
//  ErrorResponseModel.swift
//  BTG_project
//
//  Created by matheus.s.franca on 23/08/21.
//

import Foundation

class GeneralError: Codable, LocalizedError {
    var status: String?
    var code: Int?
    
    init(status: String?, code: Int?) {
        self.status = status
        self.code = code
    }
}
