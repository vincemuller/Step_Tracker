//
//  DataListView.swift
//  Step_Tracker
//
//  Created by Vince Muller on 8/18/24.
//

import SwiftUI

struct DataListView: View {
    
    @State var isShowingAddData: Bool = false
    
    var metric: HealthMetricContext
    
    var body: some View {
        List {
            ForEach(0..<28) { i in
                HStack {
                    Text(Date(), format: .dateTime.month().day().year())
                    Spacer()
                    Text(10000, format: .number.precision(.fractionLength(metric == .steps ? 0 : 1)))
                }
            }
        }
        .navigationTitle(metric.title)
        .sheet(isPresented: $isShowingAddData) {
            AddDataView(isShowingAddData: $isShowingAddData, metric: metric)
        }
        .toolbar {
            Button("Add Data", systemImage: "plus", action: {
                isShowingAddData = true
            })
        }
        .tint(metric == .steps ? .pink : .indigo)
    }
}

#Preview {
    NavigationStack {
        DataListView(metric: .weight)
    }
}

struct AddDataView: View {
    @Binding var isShowingAddData: Bool
    @State private var addDateData: Date = .now
    @State private var valueToAdd: String = ""
    
    var metric: HealthMetricContext
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $addDateData, displayedComponents: .date)
                HStack {
                    Text(metric.title)
                    Spacer()
                    TextField("Value", text: $valueToAdd)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 140)
                        .keyboardType(metric == .steps ? .numberPad : .decimalPad)
                }
            }
            .navigationTitle(metric.title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Data") {
                        //Do code later
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Dismiss") {
                        isShowingAddData = false
                    }
                }
            }
        }
    }
}
