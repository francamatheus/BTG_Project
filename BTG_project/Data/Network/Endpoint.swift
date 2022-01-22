//
//  Endpoint.swift
//  desafio-ios-matheus-frança
//
//  Created by matheus.s.franca on 24/06/20.
//  Copyright © 2020 matheus.s.franca. All rights reserved.
//

import Foundation
import Moya

enum BTG {
    case currencies
    case live
}

extension BTG: TargetType {
    public var baseURL: URL {
        if let url = URL(string: "https://btg-mobile-challenge.herokuapp.com") {
            return url
        } else {
            fatalError("⛔️ Url Doesn't exist") //Nunca caira aqui
        }
    }
    
    public var path: String {
        switch self {
        case .currencies:
            return "/list"
        case .live:
            return "/live"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .currencies, .live:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String: String]? {
        return ["accept": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
