//
//  LoanCellView.swift
//  LoanCD
//
//  Created by Metin Atalay on 19.05.2022.
//

import SwiftUI

struct LoanCellView: View {
    
    let name: String
    let amount: Double
    let date: Date
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("\(amount.toCurrency)")
                    .font(.title2)
                    .fontWeight(.light)
            }
            Spacer()
            
            Text("\(date.longDate)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct LoanCellView_Previews: PreviewProvider {
    static var previews: some View {
        LoanCellView(name: "Test", amount: 4000, date: Date())
    }
}
