//
//  LoanTrackerApp.swift
//  LoanTracker
//
//  Created by Никита Яровой on 13.03.2025.
//

import SwiftUI

@main
struct LoanTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            AllLoansView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
