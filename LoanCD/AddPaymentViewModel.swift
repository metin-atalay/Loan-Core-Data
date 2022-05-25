//
//  AddPaymentViewModel.swift
//  LoanCD
//
//  Created by Metin Atalay on 20.05.2022.
//

import Foundation

final class AddPaymentViewModel: ObservableObject {
    
    @Published var amount = ""
    @Published var date = Date()
    @Published var payment: Payment?
    
    var loanId: String
    
    init(paymentToEdit payment: Payment?, loanId: String) {
        self.payment = payment
        self.loanId = loanId
    }
    
    
    init(loanId: String) {
        self.loanId = loanId
    }
    
    func isFormValid() -> Bool {
        return amount.isEmpty
    }
    
    func createNewPayment() {
        let newPayment = Payment (context: PersistenceController.shared.viewContext)
        newPayment.id = UUID().uuidString
        newPayment.amount = Double(amount) ?? 0.0
        newPayment.date = date
        newPayment.loanId = loanId
        
        PersistenceController.shared.save()
    }
    
    func setupEditingView(){
        if let payment = payment {
            amount = "\(payment.amount)"
            date = payment.date!
            
        }
    }
    
    func updatePayment(){
        payment!.amount = Double(amount) ?? 0.0
        payment!.date = date
        
        PersistenceController.shared.save()
    }
    
    func savePayment() {
        if payment != nil {
            updatePayment()
        } else {
            createNewPayment()
        }
    }
    
}
