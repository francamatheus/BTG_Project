//
//  Rounded.swift
//  BTG_project
//
//  Created by matheus.s.franca on 23/08/21.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
