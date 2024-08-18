//
//  HealthKitPermissionPrimingView.swift
//  Step_Tracker
//
//  Created by Vince Muller on 8/18/24.
//

import SwiftUI

struct HealthKitPermissionPrimingView: View {
    
    var description = """
    This app displays your step and weight data in interactive charts.

    You can also add new step or weight data to Apple Health from this app. Your data is private and secure.
    """
    
    var body: some View {
        VStack (spacing: 80) {
            VStack (alignment: .leading) {
                Image(.healthIcon)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .shadow(color: .gray.opacity(0.3), radius: 16)
                    .padding(.bottom, 30)
                
                Text("Apple Health Integration")
                    .font(.title2.bold())
                
                Text(description)
                    .foregroundStyle(.secondary)
            }
            
            Button("Connect Apple Health") {
                //Do code later
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
        }
        .padding(30)
    }
}

#Preview {
    HealthKitPermissionPrimingView()
}
