//
//  LoanCell.swift
//  LoanTracker
//
//  Created by Никита Яровой on 14.03.2025.
//

import SwiftUI

struct LoanCell: View {
    let name: String
    let amount: Double
    let date: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(amount, format: .currency(code: "USD"))
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            Spacer()
            
            Text(date.formatted(date: .abbreviated, time: .omitted))
                .font(.subheadline)
                .fontWeight(.light)
        }
    }
}

#Preview {
    LoanCell(name: "Test Loan", amount: 1000, date: Date())
}
