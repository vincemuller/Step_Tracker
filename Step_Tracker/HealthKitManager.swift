//
//  HealthKitManager.swift
//  Step_Tracker
//
//  Created by Vince Muller on 8/18/24.
//

import Foundation
import HealthKit
import Observation

@Observable class HealthKitManager {
    
    let store = HKHealthStore()

    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
}
