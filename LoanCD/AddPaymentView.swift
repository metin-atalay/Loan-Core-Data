//
//  AddPaymentView.swift
//  LoanCD
//
//  Created by Metin Atalay on 20.05.2022.
//

import SwiftUI

struct AddPaymentView: View {
    
    
    @ObservedObject var viewModel: AddPaymentViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
   // @State var amount = ""
   // @State var date = Date()
    
    
    var body: some View {
        Form {
            Section {
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.numberPad)
                
                DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                
            }
            Section {
                Button  {
                    viewModel.savePayment()
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                

            }.disabled(viewModel.isFormValid())
        }
        .onAppear(){
            viewModel.setupEditingView()
        }
        .navigationTitle(viewModel.payment != nil ? "Edit Payment" : "Add Payment")
    }
}

