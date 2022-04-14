//
//  DatabaseManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 11.02.2022.
//

import Foundation
import RealmSwift
import CoreData

//MARK: - Database Type

enum DatabaseType {
  case realm
  case coreData
}

//MARK: - Database Manager Operations

protocol DatabaseManagerOperations {
  func save(_ objects: [Device])
  func deleteAll()
  func getDeviceObjects() -> [Device]
}

//MARK: - Database Manager

class DatabaseManager: DatabaseManagerOperations {
  static let shared = DatabaseManager(.coreData)
  private let bdName: DatabaseType
  private let realmManager = RealmManager()
  private let coreDataManager = CoreDataManager()

  
  private init(_ bdName: DatabaseType) {
    self.bdName = bdName
  }
  
  func save(_ objects: [Device]) {
    switch bdName {
      case .realm: self.realmManager.save(objects)
      case .coreData: self.coreDataManager.save(objects)
    }
  }
  
  func deleteAll() {
    switch bdName {
      case .realm: self.realmManager.deleteAll()
      case .coreData: self.coreDataManager.deleteAll()
    }
  }
  
  func getDeviceObjects() -> [Device] {
    switch bdName {
      case .realm: return Array(self.realmManager.getDeviceObjects())
      case .coreData: return self.coreDataManager.getDeviceObjects()
    }
  }
}
