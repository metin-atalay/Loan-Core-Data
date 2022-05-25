//
//  ProggressBar.swift
//  LoanCD
//
//  Created by Metin Atalay on 24.05.2022.
//

import SwiftUI

struct ProggressBar: View {
    
    var value: Double
    var leftAmount: Double
    var rightAmount: Double
    
    var body: some View {
        
        
        
        GeometryReader { geometry in
            
            ZStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                    
                    Text(leftAmount.toCurrency)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                    
                }
                
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: min(self.value*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .opacity(1)
                        .foregroundColor(Color(UIColor.systemBlue))
                    
                    Text(leftAmount.toCurrency)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                    
                }
                
                
            }
            .cornerRadius(45)
            
        }
    }
}

struct ProggressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProggressBar(value: 0.2, leftAmount: 100, rightAmount: 300)
    }
}
