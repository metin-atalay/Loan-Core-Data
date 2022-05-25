//
//  Date+Ext.swift
//  LoanCD
//
//  Created by Metin Atalay on 19.05.2022.
//

import Foundation


extension Date {
    
    var dayNumberOfYear: Int? {
        return Calendar.current.dateComponents([.year], from: self).year
    }
    
    var longDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
    
}
