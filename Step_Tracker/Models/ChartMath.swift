//
//  ChartMath.swift
//  Step_Tracker
//
//  Created by Vince Muller on 9/1/24.
//

import Foundation
import Algorithms

struct ChartMath {
    
    static func averageWeekDayCount(for metric: [HealthMetric]) -> [WeekDayChartData] {
        let sortedByWeekday = metric.sorted { $0.date.weekDayInt < $1.date.weekDayInt }
        let weekdayArray = sortedByWeekday.chunked { $0.date.weekDayInt == $1.date.weekDayInt }
        
        var weekdayChartData: [WeekDayChartData] = []
        
        for array in weekdayArray {
            guard let firstValue = array.first else { continue }
            let total = array.reduce(0) { $0 + $1.value }
            let avgSteps = total/Double(array.count)
            weekdayChartData.append(WeekDayChartData(date: firstValue.date, value: avgSteps))
        }
        return weekdayChartData
    }
}
