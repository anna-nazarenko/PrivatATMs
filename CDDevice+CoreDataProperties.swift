//
//  CDDevice+CoreDataProperties.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 13.04.2022.
//
//

import Foundation
import CoreData


extension CDDevice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDDevice> {
        return NSFetchRequest<CDDevice>(entityName: "CDDevice")
    }

    @NSManaged public var cityRU: String?
    @NSManaged public var cityUA: String?
    @NSManaged public var fullAddressEn: String?
    @NSManaged public var fullAddressRu: String?
    @NSManaged public var fullAddressUa: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var placeRu: String?
    @NSManaged public var placeUa: String?
    @NSManaged public var type: String?
    @NSManaged public var tw: CDSchedule?
    @NSManaged public var schedule: CDSchedule?

}

extension CDDevice : Identifiable {

}
