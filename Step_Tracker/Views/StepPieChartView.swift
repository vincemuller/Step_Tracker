//
//  StepPieChartView.swift
//  Step_Tracker
//
//  Created by Vince Muller on 9/2/24.
//

import SwiftUI
import Charts

struct StepPieChartView: View {
    
    @State private var rawSelectedChartValue: Double? = 0
    
    var chartData: [WeekDayChartData]
    
    var selectedWeekDay: WeekDayChartData? {
        guard let rawSelectedChartValue else {return nil}
        var total = 0.0
        
        return chartData.first {
            total += $0.value
            return rawSelectedChartValue <= total
        }
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            VStack (alignment: .leading) {
                Label("Averages", systemImage: "calendar")
                    .font(.title3.bold())
                    .foregroundColor(.pink)
                
                Text("Last 28 Days")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            ZStack {
                Chart {
                    ForEach(chartData) { weekDay in
                        SectorMark(angle: .value("Average Steps", weekDay.value),
                                   innerRadius: .ratio(0.618),
                                   outerRadius: selectedWeekDay?.date.weekDayInt == weekDay.date.weekDayInt ? 140 : 110,
                                   angularInset: 1)
                            .foregroundStyle(.pink)
                            .cornerRadius(6)
                            .opacity(selectedWeekDay?.date.weekDayInt == weekDay.date.weekDayInt ? 1.0 : 0.3)
                        
                    }
                }
                .frame(height: 240)
                .chartAngleSelection(value: $rawSelectedChartValue.animation(.easeInOut))
                if let selectedWeekDay {
                    VStack {
                        Text(selectedWeekDay.date.weekdayTitle)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .transaction { transaction in
                                transaction.animation = nil
                            }
                        Text(selectedWeekDay.value, format: .number.precision(.fractionLength(0)))
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .contentTransition(.numericText())
                    }
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
    }
}

#Preview {
    StepPieChartView(chartData: ChartMath.averageWeekDayCount(for: MockData.steps))
}
