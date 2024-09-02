//
//  StepPieChartView.swift
//  Step_Tracker
//
//  Created by Vince Muller on 9/2/24.
//

import SwiftUI
import Charts

struct StepPieChartView: View {
    
    var chartData: [WeekDayChartData]
    
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
                        SectorMark(angle: .value("Average Steps", weekDay.value), innerRadius: .ratio(0.618), angularInset: 1)
                            .foregroundStyle(.pink)
                            .cornerRadius(6)
                        
                    }
                }
                .frame(height: 240)
                Text("Label Here")
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
    }
}

#Preview {
    StepPieChartView(chartData: ChartMath.averageWeekDayCount(for: HealthMetric.mockData))
}
