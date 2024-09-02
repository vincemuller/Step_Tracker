//
//  ChartData.swift
//  Step_Tracker
//
//  Created by Vince Muller on 9/1/24.
//

import Foundation

struct WeekDayChartData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
