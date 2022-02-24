//
//  ExchangePresenter.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 23.02.2022.
//

import Foundation

class ExchangePresenter: ObservableObject  {
  private let currencyManager = CurrencyManager.shared
  var currencies: [Currency]?
}
