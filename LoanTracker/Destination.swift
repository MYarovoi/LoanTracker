//
//  Destinatio.swift
//  LoanTracker
//
//  Created by Никита Яровой on 14.03.2025.
//

import Foundation

enum Destination: Hashable {
    case payment(Loan)
    case addPayment(Loan, Payment? = nil)
}
