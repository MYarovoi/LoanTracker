//
//  AddpaymentViewModel.swift
//  LoanTracker
//
//  Created by Никита Яровой on 14.03.2025.
//

import Foundation

final class AddPaymentViewModel: ObservableObject {
    @Published var amount = ""
    @Published var date: Date = Date()
    private var loan: Loan?
    private var payment: Payment?
    
    func setLoanObject(_ loan: Loan) {
        self.loan = loan
    }
    
    func setPaymentObject(_ payment: Payment?) {
        self.payment = payment
    }
    
    func savePayment() {
        payment != nil ? updatePayment() : createNewPayment()
    }
    
    private func createNewPayment() {
        let newPayment = Payment(context: PersistenceController.shared.viewContext)
        newPayment.id = UUID().uuidString
        newPayment.amount = Double(amount) ?? 0
        newPayment.date = date
        newPayment.loan = loan
        PersistenceController.shared.save()
    }
    
    private func updatePayment() {
        guard let payment = payment else { return }
        payment.amount = Double(amount) ?? 0
        payment.date = date
        PersistenceController.shared.save()
    }
    
    func setupEditView() {
        guard let payment = payment else { return }
        amount = String(payment.amount)
        date = payment.wrappedDate
    }
    
    func isInvalidForm() -> Bool {
        amount.isEmpty
    }
}
