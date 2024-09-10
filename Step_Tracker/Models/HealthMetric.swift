//
//  HealthMetric.swift
//  Step_Tracker
//
//  Created by Vince Muller on 8/24/24.
//

import Foundation

struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
