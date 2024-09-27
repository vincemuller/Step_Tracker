//
//  WeightLineChart.swift
//  Step_Tracker
//
//  Created by Vince Muller on 9/10/24.
//

import SwiftUI
import Charts

struct WeightLineChart: View {
    
    var selectedState: HealthMetricContext
    var chartData: [HealthMetric]
    
    var minValue: Double {
        chartData.map { $0.value }.min() ?? 0
    }
    
    var body: some View {
        NavigationLink(value: selectedState, label: {
            VStack {
                HStack {
                    VStack (alignment: .leading) {
                        Label("Weight", systemImage: "figure")
                            .font(.title3.bold())
                            .foregroundColor(.indigo)
                        
                        Text("Avg: 100lbs")
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
                
                Chart {
                    RuleMark(y: .value("Goal", 155))
                        .foregroundStyle(.mint)
                        .lineStyle(.init(lineWidth: 1, dash: [5]))
                    
                    ForEach(chartData) { weight in
                        AreaMark(x: .value("Day", weight.date, unit: .day),
                                 yStart: .value("Value", weight.value),
                                 yEnd: .value("Min Value", minValue))
                        .foregroundStyle(Gradient(colors: [.indigo.opacity(0.5), .clear]))
                        .interpolationMethod(.catmullRom)
                        
                        LineMark(x: .value("Day", weight.date, unit: .day),
                                 y: .value("Value", weight.value)
                        )
                        .foregroundStyle(.indigo)
                        .interpolationMethod(.catmullRom)
                        .symbol(.circle)
                    }
                }
                .frame(height: 150)
                .chartYScale(domain: .automatic(includesZero: false))
                .chartXAxis {
                    AxisMarks {
                        AxisValueLabel(format: .dateTime.month(.defaultDigits).day())
                    }
                }
                .chartYAxis {
                    AxisMarks { value in
                        AxisGridLine()
                            .foregroundStyle(Color.secondary.opacity(0.3))
                        AxisValueLabel()
                    }
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
        })
    }
}

#Preview {
    WeightLineChart(selectedState: .weight, chartData: MockData.weights)
}
