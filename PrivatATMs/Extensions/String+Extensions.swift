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
