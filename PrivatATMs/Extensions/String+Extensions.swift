//
//  String+Extensions.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 18.02.2022.
//

import Foundation

extension String {
  func percentEncode() -> String? {
    return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
  }
}

extension String {
  func localized() -> String {
    return NSLocalizedString(
      self,
      tableName: "Localizable",
      bundle: .main,
      value: self,
      comment: self
    )
  }
}
