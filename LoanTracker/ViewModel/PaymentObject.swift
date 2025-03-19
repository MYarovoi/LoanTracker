//
//  PaymentObject.swift
//  LoanTracker
//
//  Created by Никита Яровой on 15.03.2025.
//

import Foundation

struct PaymentObject: Equatable {
    var sectionName: String
    var sectionObjects: [Payment]
    var sectionTotal: Double
}
