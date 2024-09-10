//
//  Step_TrackerApp.swift
//  Step_Tracker
//
//  Created by Vince Muller on 8/18/24.
//

import SwiftUI

@main
struct Step_TrackerApp: App {
    
    let hkManager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(hkManager)
        }
    }
}
