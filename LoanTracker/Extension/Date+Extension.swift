//
//  Date+Extension.swift
//  LoanTracker
//
//  Created by Никита Яровой on 15.03.2025.
//

import Foundation

extension Date {
    var intOfYear: Int? {
        Calendar.current.dateComponents([.year], from: self).year
    }
}
