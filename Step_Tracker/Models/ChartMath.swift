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
    
    static func averagedailyWeightDiffs(for weights: [HealthMetric]) -> [WeekDayChartData] {
        var diffValues: [(date: Date, value: Double)] = []
        
        for i in 1..<weights.count {
            let date = weights[i].date
            let diff = weights[i].value - weights[i - 1].value
            diffValues.append((date: date, value: diff))
        }
        
        let sortedByWeekday = diffValues.sorted { $0.date.weekDayInt < $1.date.weekDayInt }
        let weekdayArray = sortedByWeekday.chunked { $0.date.weekDayInt == $1.date.weekDayInt }
        
        var weekdayChartData: [WeekDayChartData] = []
        
        for array in weekdayArray {
            guard let firstValue = array.first else { continue }
            let total = array.reduce(0) { $0 + $1.value }
            let avgWeightDiff = total/Double(array.count)
            weekdayChartData.append(WeekDayChartData(date: firstValue.date, value: avgWeightDiff))
        }
        
        return weekdayChartData
    }
}
