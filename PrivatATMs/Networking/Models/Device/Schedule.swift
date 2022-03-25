//
//  Schedule.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 24.01.2022.
//

import Foundation
import RealmSwift
import Rswift

//MARK: - Schedule Model

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

//MARK: - Schedule Extension

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
      case .monday: return WorkingHoursByDay(day: R.string.localizable.workingHours_monday(), hours: mon)
      case .tuesday: return WorkingHoursByDay(day: R.string.localizable.workingHours_tuesday(), hours: tue)
      case .wednesday: return WorkingHoursByDay(day: R.string.localizable.workingHours_wednesday(), hours: wed)
      case .thursday: return WorkingHoursByDay(day: R.string.localizable.workingHours_thursday(), hours: thu)
      case .friday: return WorkingHoursByDay(day: R.string.localizable.workingHours_friday(), hours: fri)
      case .saturday: return WorkingHoursByDay(day: R.string.localizable.workingHours_saturday(), hours: sat)
      case .sunday: return WorkingHoursByDay(day: R.string.localizable.workingHours_sunday(), hours: sun)
      case .holiday: return WorkingHoursByDay(day: R.string.localizable.workingHours_holiday(), hours: hol)
    }
  }
}
