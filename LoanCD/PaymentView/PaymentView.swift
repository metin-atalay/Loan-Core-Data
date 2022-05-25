//
//  PaymentView.swift
//  LoanCD
//
//  Created by Metin Atalay on 20.05.2022.
//

import SwiftUI

struct PaymentView: View {
    @ObservedObject var viewModel: PaymentViewModel
    
    
    var body: some View {
        VStack {
            Text("Payment Progress")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top)
            
            ProggressBar(value: viewModel.progressValue(), leftAmount: viewModel.totalLeft(), rightAmount: viewModel.totalPaid())
                .frame(height: 25)
                .padding(.horizontal)
            
            Text(viewModel.expectedToFinishOn)
            
            List {
                ForEach(viewModel.allPaymentObjects, id: \.sectionName) { paymentObject in
                    
                    Section( header: Text("\(paymentObject.sectionName) - \(paymentObject.sectionTotal.toCurrency)")) {
                        ForEach(paymentObject.sectionObjects) { payment in
                            PaymentCellView(amount: payment.amount, date: payment.date ?? Date())
                                .onTapGesture {
                                    viewModel.isNavigationLinkActive = true
                                    viewModel.selectedPayment = payment
                                }
                        }
                        .onDelete { index in
                            viewModel.delete(paymentObject: paymentObject, index: index)
                        }
                    }
                    
                   
                }
               
            }
            .listStyle(PlainListStyle())
            
            
        }
        .navigationTitle(viewModel.loan.name ?? "")
        .navigationBarItems(trailing:
                                Button(action: {
            viewModel.isNavigationLinkActive = true
        }, label: {
            Image(systemName: "plus")
        })
                                    .background(
                                        NavigationLink(destination: AddPaymentView(viewModel: AddPaymentViewModel(paymentToEdit: viewModel.selectedPayment, loanId: viewModel.loan.id ?? "")), isActive: $viewModel.isNavigationLinkActive) {
                                        //EmptyView()
                                    }
                                          //  .hidden()
                                    )
                            
                            
        )
        .onAppear {
            viewModel.selectedPayment = nil
            viewModel.fetchAllPayments()
            viewModel.calculateDays()
            viewModel.separateByYear()
        }
    }
}

