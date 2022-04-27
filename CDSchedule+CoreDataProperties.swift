//
//  CDSchedule+CoreDataProperties.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 14.04.2022.
//
//

import Foundation
import CoreData


extension CDSchedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDSchedule> {
        return NSFetchRequest<CDSchedule>(entityName: "CDSchedule")
    }

    @NSManaged public var mon: String?
    @NSManaged public var tue: String?
    @NSManaged public var wed: String?
    @NSManaged public var thu: String?
    @NSManaged public var fri: String?
    @NSManaged public var sat: String?
    @NSManaged public var sun: String?
    @NSManaged public var hol: String?
    @NSManaged public var device: CDDevice?

}

extension CDSchedule : Identifiable {

}
