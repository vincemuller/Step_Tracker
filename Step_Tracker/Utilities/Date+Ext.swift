//
//  Date+Ext.swift
//  Step_Tracker
//
//  Created by Vince Muller on 9/1/24.
//

import Foundation

extension Date {
    var weekDayInt: Int {
        Calendar.current.component(.weekday, from: self)
    }
    
    var weekdayTitle: String {
        self.formatted(.dateTime.weekday(.wide))
    }
}
