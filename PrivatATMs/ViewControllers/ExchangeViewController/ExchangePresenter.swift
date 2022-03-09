//
//  ExchangePresenter.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 23.02.2022.
//

import Foundation
import SwiftUI

enum CurrencyType: String {
  case bank
  case privat24
}

class ExchangePresenter: ObservableObject  {
  private let currencyManager = CurrencyManager.shared
  @Published var bankCurrencies: [Currency]?
  @Published var privat24Currencies: [Currency]?
  @Published var buyRate: Double? = 28.16
  @Published var saleRate: Double? = 28.31
  let currencyImages2 = [
    "USD": "dollarsign.circle.fill",
    "EUR": "eurosign.circle.fill",
    "RUR": "rublesign.circle.fill",
    "BTC": "bitcoinsign.circle.fill"
  ]
  private let currencyImages = ["dollarsign.circle.fill", "eurosign.circle.fill", "bitcoinsign.circle.fill"]
  
  init() {
    self.currencyManager.delegate = self
  }
  
  func updateCurrencyRate(id: Int, from: CurrencyType) {
    var selectedCurrency: Currency?
    
    switch from {
    case .bank:
      selectedCurrency = bankCurrencies?[id]
      
    case .privat24:
      selectedCurrency = privat24Currencies?[id]
    }
    
    if let currency = selectedCurrency {
      buyRate = Double(currency.buy)
      saleRate = Double(currency.sale)
    }
  }
  
  func getImageName(by currency: String) -> String {
    return currencyImages2[currency] ?? ""
  }
}

extension ExchangePresenter: CurrencyManagerDelegate {
  func didUpdateCurrencies(data: [Currency], from: CurrencyType) {
    switch from {
    case .bank:
      self.bankCurrencies = data
    case .privat24:
      self.privat24Currencies = data
    }
  }
  
  func didFailWithError(message: String) {
    print(message)
  }
}
