//
//  PaymentsView.swift
//  LoanTracker
//
//  Created by Никита Яровой on 14.03.2025.
//

import SwiftUI

struct PaymentsView: View {
    @StateObject var viewModel = PaymentViewModel()
    var loan: Loan
    
    @ViewBuilder
    private func addButton() -> some View {
        NavigationLink(value: Destination.addPayment(loan)) {
            Image(systemName: "plus.circle")
                .font(.title3)
        }
        .padding([.vertical, .leading], 5)
    }
    
    @ViewBuilder
    private func progressView() -> some View {
        VStack {
            Text("Peyment progress")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.top)
            
            ProgressBar(progress: viewModel.progress)
                .padding(.horizontal)
            
            Text(viewModel.expectedToFinishOn)
        }
    }
    
    var body: some View {
        VStack {
            progressView()

            List {
                ForEach(viewModel.allPaymentsObject, id: \.sectionName) { peymentsObject in
                    Section(header: Text("\(peymentsObject.sectionName) - \(peymentsObject.sectionTotal, format: .currency(code: "USD"))")) {
                        ForEach(peymentsObject.sectionObjects) { payment in
                            NavigationLink(value: Destination.addPayment(loan, payment)) {
                                PaymentCell(amount: payment.amount, date: payment.wrappedDate)
                            }
                        }
                        .onDelete { index in
                            viewModel.deleteItem(peymentsObject: peymentsObject, index: index)
                        }
                    }
                }
            }
            .listStyle(.grouped)
        }
        .navigationTitle(loan.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                addButton()
            }
        }
        .onAppear {
            viewModel.setLoanObject(loan)
            viewModel.calculateProgress()
            viewModel.calculateDays()
            viewModel.separateByYear()
        }
    }
}

