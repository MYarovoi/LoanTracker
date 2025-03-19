//
//  Payment+CoreDataProperties.swift
//  LoanTracker
//
//  Created by Никита Яровой on 13.03.2025.
//
//

import Foundation
import CoreData


extension Payment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payment> {
        return NSFetchRequest<Payment>(entityName: "Payment")
    }

    @NSManaged public var amount: Double
    @NSManaged public var id: String?
    @NSManaged public var date: Date?
    @NSManaged public var loan: Loan?
    
    public var wrappedDate: Date {
        date ?? Date()
    }

}

extension Payment : Identifiable {

}
