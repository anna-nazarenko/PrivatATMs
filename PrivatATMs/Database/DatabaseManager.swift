//
//  DatabaseManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 11.02.2022.
//

import Foundation
import RealmSwift

//MARK: - Database Type

enum DatabaseType {
  case realm
  case coreData
}

//MARK: - Database Manager Operations

protocol DatabaseManagerOperations {
  func save(_ objects: [Object])
  func deleteAll()
  func getDeviceObjects() -> Results<Device>
}

//MARK: - Database Manager

class DatabaseManager: DatabaseManagerOperations {
  static let shared = DatabaseManager(.realm)
  private let realmManager = RealmManager()
  private let bdName: DatabaseType
  
  private init(_ bdName: DatabaseType) {
    self.bdName = bdName
  }
  
  func save(_ objects: [Object]) {
    switch bdName {
      
    case .realm:
      self.realmManager.save(objects)
      
    case .coreData:
      print("Do something")
    }
  }
  
  func deleteAll() {
    switch bdName {
      
    case .realm:
      self.realmManager.deleteAll()
      
    case .coreData:
      print("Do something")
    }
  }
  
  func getDeviceObjects() -> Results<Device> {
    switch bdName {
      
    case .realm:
      return self.realmManager.getDeviceObjects()
      
    case .coreData:
      return self.realmManager.getDeviceObjects() //Change to getDeviceObjects from CoreData Manager
    }
  }
}
