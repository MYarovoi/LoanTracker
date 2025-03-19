//
//  ProgressBar.swift
//  LoanTracker
//
//  Created by Никита Яровой on 14.03.2025.
//

import SwiftUI

struct ProgressBar: View {
    private let progress: Progress
    private let barHeight: CGFloat
    
    init(progress: Progress, barHeight: CGFloat = 20) {
        self.progress = progress
        self.barHeight = barHeight
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Rectangle()
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundStyle(Color(UIColor.systemTeal))
                    
                    Text(progress.leftAmount, format: .currency(code: "USD"))
                        .font(.caption)
                        .foregroundStyle(.red)
                        .padding(.horizontal)
                }
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: min(CGFloat(progress.value) * geometry.size.width, geometry.size.width),
                               height: geometry.size.height)
                        .foregroundStyle(Color(UIColor.systemBlue))
                    
                    Text(progress.paidAmount, format: .currency(code: "USD"))
                        .font(.caption)
                        .padding(.horizontal)
                }
            }
            .cornerRadius(45)
        }
        .frame(height: barHeight)
    }
}

#Preview {
    ProgressBar(progress: Progress())
}
