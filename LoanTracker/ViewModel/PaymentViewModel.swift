//
//  PaymentViewModel.swift
//  LoanTracker
//
//  Created by Никита Яровой on 14.03.2025.
//

import Foundation
import SwiftUI

final class PaymentViewModel: ObservableObject {
    private var loan: Loan?
    @Published private(set) var expectedToFinishOn = ""
    @Published private(set) var progress = Progress()
    @Published private(set) var allPayments: [Payment] = []
    @Published private(set) var allPaymentsObject: [PaymentObject] = []
    
    func setLoanObject(_ loan: Loan) {
        self.loan = loan
        setPayments()
    }
    
    private func setPayments() {
        guard let loan = loan else { return }
        allPayments = loan.paymentArray
    }
    
    func calculateProgress() {
        guard let loan = loan else { return }
        let totalPaid = allPayments.reduce(0) { $0 + $1.amount }
        let totalLeft = loan.totalAmount - totalPaid
        let value = totalPaid / loan.totalAmount
        
        progress = Progress(value: value, leftAmount: totalLeft, paidAmount: totalPaid)
    }
    
    func separateByYear() {
        let dict = Dictionary(grouping: allPayments) { $0.wrappedDate.intOfYear}
        
        for (key, value) in dict {
            guard let key = key else { return }
            
            let total = value.reduce(0) { $0 + $1.amount }
            allPaymentsObject.append(PaymentObject(sectionName: "\(key)", sectionObjects: value.reversed(), sectionTotal: total))
        }
        
        allPaymentsObject.sorted(by: { $0.sectionName < $1.sectionName })
    }
    
    func calculateDays() {
        guard let loan = loan else { return }
        let totalPaid = allPayments.reduce(0) { $0 + $1.amount }
        let totalDays = Calendar.current.dateComponents([.day], from: loan.wrappedStartDate, to: loan.wrappedDueDate).day!
        let passedDays = Calendar.current.dateComponents([.day], from: loan.wrappedStartDate, to: Date()).day!
        
        if passedDays == 0 || totalPaid == 0 {
            expectedToFinishOn = ""
            return
        }
        
        let didPayPerDay = totalPaid / Double(passedDays)
        let sholdPayPerDay = loan.totalAmount / Double(totalDays)
        let daysToFinish = (loan.totalAmount - totalPaid) / didPayPerDay
        let newDate = Calendar.current.date(byAdding: .day, value: Int(daysToFinish), to: Date())
        
        guard let newDate = newDate else {
            expectedToFinishOn = ""
            return
        }
        expectedToFinishOn = "Expected to finish on: \(newDate.formatted(date: .long, time: .omitted))"
    }
    
    func deleteItem(peymentsObject: PaymentObject, index: IndexSet) {
        guard let deleteIndex = index.first else { return }
        let peymentToDelete = peymentsObject.sectionObjects[deleteIndex]
        
        PersistenceController.shared.viewContext.delete(peymentToDelete)
        PersistenceController.shared.save()
        
        setPayments()
        withAnimation {
            calculateProgress()
            calculateDays()
        }
        separateByYear()
    }
}
