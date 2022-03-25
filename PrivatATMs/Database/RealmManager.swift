//
//  RealmManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 17.02.2022.
//

import Foundation
import RealmSwift


class RealmManager {
  
  let realm = try! Realm()
  
  func save(_ objects: [Object]) {
    do {
      try self.realm.write {
        self.realm.add(objects)
      }
    } catch {
      print("Error saving data to Realm: \(error)")
    }
  }
  
  func deleteAll() {
    do {
      try self.realm.write {
        self.realm.deleteAll()
      }
    } catch {
      print("Error deleting all data from Realm: \(error)")
    }
  }
  
  func getDeviceObjects() -> Results<Device> {
    return self.realm.objects(Device.self)
  }
}
