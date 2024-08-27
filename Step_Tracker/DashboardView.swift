//
//  DashboardView.swift
//  Step_Tracker
//
//  Created by Vince Muller on 8/18/24.


import SwiftUI
import Charts

enum HealthMetricContext: CaseIterable, Identifiable {
    case steps, weight
    var id: Self { self }
    var title: String {
        switch self {
        case .steps:
            return "Steps"
        case .weight:
            return "Weight"
        }
    }
}

struct DashboardView: View {
    
    @Environment(HealthKitManager.self) private var hkManager
    @AppStorage("hasSeenPermissionPriming") private var hasSeenPermissionPriming = false
    @State private var isShowingPermissionPrimingSheet = false
    @State private var selectedState: HealthMetricContext = .steps
    var isSteps: Bool {return selectedState == .steps}
    
    var avgStepCount: Double {
        guard !hkManager.stepData.isEmpty else {return 0}
        let totalSteps = hkManager.stepData.reduce(0) {$0 + $1.value}
        return totalSteps/Double(hkManager.stepData.count)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20) {
                    Picker("Selected Stat", selection: $selectedState) {
                        ForEach(HealthMetricContext.allCases) {
                            Text($0.title)
                        }
                    }.pickerStyle(.segmented)
                    NavigationLink(value: selectedState, label: {
                        VStack {
                            HStack {
                                VStack (alignment: .leading) {
                                    Label("Steps", systemImage: "figure.walk")
                                        .font(.title3.bold())
                                        .foregroundColor(.pink)
                                    
                                    Text("Avg: \(Int(avgStepCount)) steps")
                                        .font(.caption)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.secondary)
                            .padding(.bottom, 12)
                            
                            Chart {
                                RuleMark(y: .value("Average", avgStepCount))
                                    .foregroundStyle(Color.secondary)
                                    .lineStyle(.init(lineWidth: 1, dash: [5]))
                                ForEach(hkManager.stepData) { step in
                                    BarMark(x: .value("Date", step.date, unit: .day),
                                            y: .value("Steps", step.value)
                                    )
                                    .foregroundStyle(Color.pink.gradient)
                                }
                            }
                            .frame(height: 150)
                            .chartXAxis {
                                AxisMarks {
                                    AxisValueLabel(format: .dateTime.month(.defaultDigits).day())
                                }
                            }
                            .chartYAxis {
                                AxisMarks { value in
                                    AxisGridLine()
                                        .foregroundStyle(Color.secondary.opacity(0.3))
                                    AxisValueLabel((value.as(Double.self) ?? 0).formatted(.number.notation(.compactName)))
                                }
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
                    })
                    VStack (alignment: .leading) {
                        VStack (alignment: .leading) {
                            Label("Averages", systemImage: "calendar")
                                .font(.title3.bold())
                                .foregroundColor(.pink)
                            
                            Text("Last 28 Days")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Chart {
                            ForEach(hkManager.weightData) { weight in
                                BarMark(x: .value("Date", weight.date, unit: .day), y: .value("Weight", weight.value))
                            }
                        }
                        .frame(height: 150)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
                }
            }
            .padding()
            .task {
                await hkManager.fetchStepCount()
//                await hkManager.fetchWeights()
//                await hkManager.addSimulatorData()
                isShowingPermissionPrimingSheet = !hasSeenPermissionPriming
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: HealthMetricContext.self, destination: { metric in
                DataListView(metric: metric)
            })
            .sheet(isPresented: $isShowingPermissionPrimingSheet, onDismiss: {
                //fetch HealthKit data
            }, content: {
                HealthKitPermissionPrimingView(hasSeen: $hasSeenPermissionPriming)
            })
            
        }
        .tint(isSteps ? .pink : .indigo)
    }
}

#Preview {
    DashboardView()
        .environment(HealthKitManager())
}
