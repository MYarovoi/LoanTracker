//
//  ContentView.swift
//  LoanTracker
//
//  Created by Никита Яровой on 13.03.2025.
//

import SwiftUI
import CoreData

struct AllLoansView: View {
    @Environment(\.managedObjectContext) var viewCintext
    
    @State private var isAddLoanShowing = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Loan.startDate, ascending: true)], animation: .default)
    
    private var loans: FetchedResults<Loan>
    
    @ViewBuilder
    private func addButton() -> some View {
        Button {
            isAddLoanShowing = true
        } label: {
            Image(systemName: "plus.circle")
                .font(.title3)
        }
        .padding([.vertical, .leading], 5)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(loans) { loan in
                    NavigationLink(value: Destination.payment(loan)) {
                        LoanCell(name: loan.wrappedName, amount: loan.totalAmount, date: loan.wrappedDueDate)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("All Loans")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    addButton()
                }
            }
            .sheet(isPresented: $isAddLoanShowing) {
                AddLoanView()
            }
            .navigationDestination(for: Destination.self) { destiantion in
                switch destiantion {
                case .payment(let loan):
                    PaymentsView(loan: loan)
                case .addPayment(let loan, let payment):
                    AddPaymentView(loan: loan, payment: payment)
                }
            }
        }
    }
    
    func deleteItems(offset: IndexSet) {
        withAnimation {
            offset.map { loans[$0]}.forEach(viewCintext.delete)
            PersistenceController.shared.save()
        }
    }
}

#Preview {
    AllLoansView()
}
