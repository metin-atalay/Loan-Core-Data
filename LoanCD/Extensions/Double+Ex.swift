//
//  Double+Ex.swift
//  LoanCD
//
//  Created by Metin Atalay on 19.05.2022.
//

import Foundation


extension Double {
    var toCurrency: String {
        let currenyFormatter = NumberFormatter()
        currenyFormatter.usesGroupingSeparator = true
        
        currenyFormatter.maximumFractionDigits = 0
        currenyFormatter.numberStyle = .currency
        
        currenyFormatter.locale = Locale.current
        
        let priceString = currenyFormatter.string(from: NSNumber(value: self))!
        
        return priceString
    }
}
