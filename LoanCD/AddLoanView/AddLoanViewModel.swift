//
//  AddLoanViewModel.swift
//  LoanCD
//
//  Created by Metin Atalay on 19.05.2022.
//

import Foundation
import SwiftUI

final class AddLoanViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var amount = ""
    @Published var startDate = Date()
    @Published var dueDate = Date()
    
    var isAddLoanShowing : Binding<Bool>
    
    init(isAddLoanShowing : Binding<Bool>) {
        self.isAddLoanShowing = isAddLoanShowing
    }
    
    func isValidForm() -> Bool {
        return name.isEmpty || amount.isEmpty
    }
    
    func saveLoan(){
        let newLoan = Loan(context: PersistenceController.shared.viewContext)
        newLoan.id = UUID().uuidString
        newLoan.name = name
        newLoan.totalAmount = Double(amount) ?? 0
        newLoan.startDate = startDate
        newLoan.dueDate = dueDate
        
        PersistenceController.shared.save()
        
    }
    
}
