//
//  ATMsData.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 20.01.2022.
//

import Foundation

struct Result: Codable {
    let devices: [Device]
}

struct Device: Codable {
    let type: String
    let cityRU: String
    let cityUA: String
    let cityEN: String
    let fullAddressRu: String
    let fullAddressUa: String
    let fullAddressEn: String
    let placeRu: String
    let placeUa: String
    let latitude: String
    let longitude: String
    let tw: Schedule
}

struct Schedule: Codable {
    let mon: String
    let tue: String
    let wed: String
    let thu: String
    let fri: String
    let sat: String
    let sun: String
    let hol: String
}
