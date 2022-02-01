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
    let cityEN: CityEn
    let fullAddressRu: String
    let fullAddressUa: String
    let fullAddressEn: String?
    let placeRu: String
    let placeUa: String
    let latitude: String
    let longitude: String
    let tw: Schedule
}

enum CityEn: Codable {
    case string(String)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let decodedValue = try? container.decode([String].self) {
            self = .stringArray(decodedValue)
            return
        }
        if let decodedValue = try? container.decode(String.self) {
            self = .string(decodedValue)
            return
        }
        throw DecodingError.typeMismatch(CityEn.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for cityEn"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .stringArray(let value):
            try container.encode(value)
        }
    }
}
