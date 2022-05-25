//
//  LoansView.swift
//  LoanCD
//
//  Created by Metin Atalay on 19.05.2022.
//

import SwiftUI
import CoreData

struct LoansView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Loan.startDate, ascending: true)],
        animation: .default)
    private var loans: FetchedResults<Loan>
    
    @State var showAddLoanView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(loans) { loan in
                    
                    NavigationLink(destination: PaymentView(viewModel: PaymentViewModel(loan: loan))) {
                        
                        LoanCellView(name: loan.name ?? "unknown loan", amount: loan.totalAmount, date: loan.dueDate ?? Date())
                    }
                    
                    
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("All Loans")
            .navigationBarItems( trailing:
                                    
                                    Button(action: {
                showAddLoanView = true
                // addItem()
            }, label: {
                Image(systemName: "plus")
            })                
            )
        }
        .accentColor(Color(.label))
        .sheet(isPresented: $showAddLoanView) {
            AddLoanView(viewModel: AddLoanViewModel(isAddLoanShowing: $showAddLoanView))
        }
    }
    
    private func addItem() {
        withAnimation {
            let newLoan = Loan(context: viewContext)
            newLoan.name = "Test Loan"
            newLoan.startDate = Date()
            newLoan.dueDate = Date()
            newLoan.totalAmount = 100000
            newLoan.id = "1"
            
            do {
                try viewContext.save()
            } catch {
                print("saved error \(error.localizedDescription)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { loans[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                print("deleted  error \(error.localizedDescription)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoansView()
    }
}
