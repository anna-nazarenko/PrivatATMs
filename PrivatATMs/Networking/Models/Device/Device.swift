//
//  ATMsData.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 20.01.2022.
//

import Foundation
import RealmSwift

struct Result: Codable {
    let devices: [Device]
}

protocol PrimaryKeyProtocol {
    var deviceID: ObjectId { get }
    func primaryKey() -> String?
}

class Device: Object, Codable {

    @Persisted var type: String
    @Persisted var cityRU: String
    @Persisted var cityUA: String
    let cityEN: CityEn
    @Persisted var fullAddressRu: String
    @Persisted var fullAddressUa: String
    @Persisted var fullAddressEn: String?
    @Persisted var placeRu: String
    @Persisted var placeUa: String
    @Persisted var latitude: String
    @Persisted var longitude: String
    @Persisted var tw: Schedule?
}

extension Device: PrimaryKeyProtocol {
    var deviceID: ObjectId {
        return ObjectId.generate()
    }
    
    func primaryKey() -> String? {
        return "deviceID"
    }
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
