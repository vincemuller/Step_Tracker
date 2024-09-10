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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20) {
                    Picker("Selected Stat", selection: $selectedState) {
                        ForEach(HealthMetricContext.allCases) {
                            Text($0.title)
                        }
                    }.pickerStyle(.segmented)
                    StepBarChartView(selectedState: selectedState, chartData: hkManager.stepData)
                    StepPieChartView(chartData: ChartMath.averageWeekDayCount(for: hkManager.stepData))
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
