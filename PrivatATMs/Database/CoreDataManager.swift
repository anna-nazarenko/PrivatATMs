//
//  CoreDataManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 17.02.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  private func deleteEntity(name: String) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

    do { try self.context.execute(batchDeleteRequest) }
    catch { print("Detele all data in \(name) error :", error) }
  }
  
  func save(_ objects: [Device]) {
    
    for device in objects {
      let cdDevice = CDDevice(context: self.context)
      
      let cdSchedule = CDSchedule(context: self.context)
      guard let schedule = device.tw else { return }

      cdSchedule.mon = schedule.mon
      cdSchedule.tue = schedule.tue
      cdSchedule.wed = schedule.wed
      cdSchedule.thu = schedule.thu
      cdSchedule.fri = schedule.fri
      cdSchedule.sat = schedule.sat
      cdSchedule.sun = schedule.sun
      cdSchedule.hol = schedule.hol
      cdSchedule.device = cdDevice
      
      cdDevice.type = device.type
      cdDevice.latitude = device.latitude
      cdDevice.longitude = device.longitude
      cdDevice.fullAddressRu = device.fullAddressRu
      cdDevice.fullAddressUa = device.fullAddressUa
      cdDevice.fullAddressEn = device.fullAddressEn
      cdDevice.placeRu = device.placeRu
      cdDevice.placeUa = device.placeUa
      cdDevice.cityRU = device.cityRU
      cdDevice.cityUA = device.cityUA
      cdDevice.schedule = cdSchedule

      do { try self.context.save() }
      catch let error as NSError { print("Error saving context \(error) \(error.userInfo)") }
    }
  }
  
  func deleteAll() {
    deleteEntity(name: "CDDevice")
    deleteEntity(name: "CDSchedule")
  }
  
  func getDeviceObjects() -> [Device] {
    var devices: [Device] = []
    var coreDataDevices: [CDDevice] = []
    let fetchCDDevices: NSFetchRequest<CDDevice> = CDDevice.fetchRequest()

    do { coreDataDevices = try self.context.fetch(fetchCDDevices) }
    catch { print("Error getting devices from Core Data \(error)") }
    
    for cdDevice in coreDataDevices {
      let device = Device()
      let schedule = Schedule()
      
      schedule.mon = cdDevice.schedule?.mon ?? ""
      schedule.tue = cdDevice.schedule?.tue ?? ""
      schedule.wed = cdDevice.schedule?.wed ?? ""
      schedule.thu = cdDevice.schedule?.thu ?? ""
      schedule.fri = cdDevice.schedule?.fri ?? ""
      schedule.sat = cdDevice.schedule?.sat ?? ""
      schedule.sun = cdDevice.schedule?.sun ?? ""
      schedule.hol = cdDevice.schedule?.hol ?? ""
      
      device.tw = schedule
      device.type = cdDevice.type ?? ""
      device.latitude = cdDevice.latitude ?? ""
      device.longitude = cdDevice.longitude ?? ""
      device.fullAddressRu = cdDevice.fullAddressRu ?? ""
      device.fullAddressUa = cdDevice.fullAddressUa ?? ""
      device.fullAddressEn = cdDevice.fullAddressEn ?? ""
      device.placeRu = cdDevice.placeRu ?? ""
      device.placeUa = cdDevice.placeUa ?? ""
      device.cityRU = cdDevice.cityRU ?? ""
      device.cityUA = cdDevice.cityUA ?? ""

      devices.append(device)
    }
    
    return devices
  }
  
}
