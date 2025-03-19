//
//  AddPaymentView.swift
//  LoanTracker
//
//  Created by Никита Яровой on 14.03.2025.
//

import SwiftUI

struct AddPaymentView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AddPaymentViewModel()
    var loan: Loan
    var payment: Payment?
    
    @ViewBuilder
    private func saveButton() -> some View {
        Button {
            viewModel.savePayment()
            dismiss()
        } label: {
            Text("Done")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .disabled(viewModel.isInvalidForm())
    }
    
    var body: some View {
        Form {
            TextField("Amount", text: $viewModel.amount)
                .keyboardType(.numberPad)
            
            DatePicker("Date", selection: $viewModel.date, in: Date()..., displayedComponents: .date)
        }
        .navigationTitle(payment != nil ? "Edit Payment" : "Add Payment")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                saveButton()
            }
        }
        .onAppear {
            viewModel.setLoanObject(loan)
            viewModel.setPaymentObject(payment)
            viewModel.setupEditView()
        }
    }
}
