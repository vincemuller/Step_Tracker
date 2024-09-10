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
                    ForEach(chartData) { weight in
                        AreaMark(x: .value("Day", weight.date, unit: .day),
                                 y: .value("Value", weight.value)
                        )
                        .foregroundStyle(Gradient(colors: [.indigo.opacity(0.5), .clear]))
                        
                        LineMark(x: .value("Day", weight.date, unit: .day),
                                 y: .value("Value", weight.value)
                        )
                        .foregroundStyle(.indigo)
                    }
                }
                .frame(height: 150)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
        })
    }
}

#Preview {
    WeightLineChart(selectedState: .weight, chartData: MockData.weights)
}
