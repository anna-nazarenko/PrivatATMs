//
//  Schedule.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 24.01.2022.
//

import Foundation

struct Schedule: Codable {
    let mon: String
    let tue: String
    let wed: String
    let thu: String
    let fri: String
    let sat: String
    let sun: String
    let hol: String
    
    var numberOfDays: Int {
        return Day.allCases.count
    }
    
    struct WorkingHoursByDay {
        var day: String
        var hours: String
    }
    
    enum Day: Int, CaseIterable {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday, holiday
    }
    
    func getWorkingHoursByDay(_ forIndex: Int) -> WorkingHoursByDay {
        let day: Day = Day(rawValue: forIndex) ?? .holiday
        
        switch day {
        case .monday:
            return WorkingHoursByDay(day: "Monday", hours: mon)
        case .tuesday:
            return WorkingHoursByDay(day: "Tuesday", hours: tue)
        case .wednesday:
            return WorkingHoursByDay(day: "Wednesday", hours: wed)
        case .thursday:
            return WorkingHoursByDay(day: "Thursday", hours: thu)
        case .friday:
            return WorkingHoursByDay(day: "Friday", hours: fri)
        case .saturday:
            return WorkingHoursByDay(day: "Saturday", hours: sat)
        case .sunday:
            return WorkingHoursByDay(day: "Sunday", hours: sun)
        case .holiday:
            return WorkingHoursByDay(day: "Holiday", hours: hol)
        }
    }
}
