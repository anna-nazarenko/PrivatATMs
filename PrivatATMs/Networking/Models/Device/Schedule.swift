//
//  Schedule.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 24.01.2022.
//

import Foundation
import RealmSwift

class Schedule: Object, Codable {
  @Persisted var mon: String
  @Persisted var tue: String
  @Persisted var wed: String
  @Persisted var thu: String
  @Persisted var fri: String
  @Persisted var sat: String
  @Persisted var sun: String
  @Persisted var hol: String
}

extension Schedule {
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
      return WorkingHoursByDay(day: "WorkingHours_monday".localized(), hours: mon)
    case .tuesday:
      return WorkingHoursByDay(day: "WorkingHours_tuesday".localized(), hours: tue)
    case .wednesday:
      return WorkingHoursByDay(day: "WorkingHours_wednesday".localized(), hours: wed)
    case .thursday:
      return WorkingHoursByDay(day: "WorkingHours_thursday".localized(), hours: thu)
    case .friday:
      return WorkingHoursByDay(day: "WorkingHours_friday".localized(), hours: fri)
    case .saturday:
      return WorkingHoursByDay(day: "WorkingHours_saturday".localized(), hours: sat)
    case .sunday:
      return WorkingHoursByDay(day: "WorkingHours_sunday".localized(), hours: sun)
    case .holiday:
      return WorkingHoursByDay(day: "WorkingHours_holiday".localized(), hours: hol)
    }
  }
}
