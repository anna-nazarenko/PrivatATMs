//
//  ExchangePresenter.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 23.02.2022.
//

import Foundation
import SwiftUI

class ExchangePresenter: ObservableObject  {
  private let currencyManager = CurrencyManager.shared
  @Published var currencies: [Currency]?
  @Published var buyRate: Double? = 28.16
  @Published var saleRate: Double? = 28.31
  
  init() {
    self.currencyManager.delegate = self
  }
  
  func updateCurrencyRate(id: Int) {
    if let selectedCurrency = currencies?[id] {
      buyRate = Double(selectedCurrency.buy)
      saleRate = Double(selectedCurrency.sale)
    }
  }
}

extension ExchangePresenter: CurrencyManagerDelegate {
  func didUpdateCurrencies(data: [Currency]) {
    self.currencies = data
  }
  
  func didFailWithError(message: String) {
    print(message)
  }
}
