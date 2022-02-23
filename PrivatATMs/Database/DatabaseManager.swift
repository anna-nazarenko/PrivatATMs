//
//  DatabaseManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 11.02.2022.
//

import Foundation
import RealmSwift

enum DB {
    case realm
    case coreData
}

protocol DatabaseManagerOperations {
    func save(_ objects: [Object])
    func deleteAll()
    func getDeviceObjects() -> Results<Device>
}

class DatabaseManager: DatabaseManagerOperations {
    static let shared = DatabaseManager(.realm)
    private let realmManager = RealmManager()
    private let bdName: DB
    
    private init(_ bdName: DB) {
        self.bdName = bdName
    }
    
    func save(_ objects: [Object]) {
        switch bdName {
            
        case .realm:
            self.realmManager.save(objects)
            
        case .coreData:
            print("do something")
        }
    }
    
    func deleteAll() {
        switch bdName {
            
        case .realm:
            self.realmManager.deleteAll()
            
        case .coreData:
            print("do something")
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
