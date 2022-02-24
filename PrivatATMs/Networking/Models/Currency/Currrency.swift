//
//  Currrency.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 23.02.2022.
//

import Foundation

struct Currency: Codable {
  var ccy: String
  var base_ccy: String
  var buy: String
  var sale: String
}
