//
//  AddLoanViewModel.swift
//  LoanTracker
//
//  Created by Никита Яровой on 13.03.2025.
//

import Foundation

final class AddLoanViewModel: ObservableObject {
    @Published var name = ""
    @Published var amount = ""
    @Published var startDate = Date()
    @Published var dueDate = Date()
    
    func isInvalidForm() -> Bool {
        name.isEmpty || amount.isEmpty
    }
    
    func saveLoan() {
        let loan = Loan(context: PersistenceController.shared.viewContext)
        loan.id = UUID().uuidString
        loan.name = name
        loan.totalAmount = Double(amount) ?? 0.0
        loan.startDate = startDate
        loan.dueDate = dueDate
        
        PersistenceController.shared.save()
    }
}
