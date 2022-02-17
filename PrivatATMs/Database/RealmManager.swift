//
//  RealmManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 17.02.2022.
//

import Foundation
import RealmSwift

protocol DatabaseManagerOperations {
    func save(_ objects: [Object])
    func delete(_ object: Object)
    func deleteAll()
    func realmDevicesIsEmpty() -> Bool
    func getDeviceObjects() -> Results<Device>
}

class RealmManager: DatabaseManagerOperations {
    let realm = try! Realm()
    
    func save(_ objects: [Object]) {
        do {
            try self.realm.write {
                realm.add(objects, update: .all)
            }
            
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
    
    func delete(_ object: Object) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting Realm Object: \(error)")
        }
    }
    
    func deleteAll() {
        do {
            try self.realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Error deleting all data from Realm: \(error)")
        }
    }
    
    func realmDevicesIsEmpty() -> Bool {
        return getDeviceObjects().isEmpty
    }
    
    func getDeviceObjects() -> Results<Device> {
        return realm.objects(Device.self)
    }
}
