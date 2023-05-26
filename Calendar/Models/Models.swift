//
//  Models.swift
//  Calendar
//
//  Created by Nik Y on 26.05.2023.
//

import UIKit

// Модель дня
struct Day {
    let date: Date
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    var dayOfMonth: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
}

// Модель недели
struct Week {
    let days: [Day]
    let year: Int
    let weekOfYear: Int
}
