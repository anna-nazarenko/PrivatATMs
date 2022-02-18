//
//  DatabaseManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 11.02.2022.
//

import Foundation

class DatabaseManager {
    
    static let shared = DatabaseManager(.realm)
    let bdName: BDName
    
    private init(_ bdName: BDName) {
        self.bdName = bdName
    }
    
}

enum BDName: String {
    case realm = "Realm"
    case coreData = "CoreData"
}
