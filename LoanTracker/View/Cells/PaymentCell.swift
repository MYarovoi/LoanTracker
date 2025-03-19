//
//  PaymentCell.swift
//  LoanTracker
//
//  Created by Никита Яровой on 14.03.2025.
//

import SwiftUI

struct PaymentCell: View {
    let amount: Double
    let date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(amount, format: .currency(code: "USD"))
                .font(.headline)
                .fontWeight(.semibold)
            Text(date.formatted(date: .abbreviated, time: .omitted))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
