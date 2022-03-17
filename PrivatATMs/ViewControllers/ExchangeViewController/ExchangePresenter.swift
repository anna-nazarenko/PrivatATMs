//
//  ExchangePresenter.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 23.02.2022.
//

import Foundation
import SwiftUI
import Network

enum CurrencyType: String {
  case bank
  case privat24
}

class ExchangePresenter: ObservableObject  {
  private let currencyManager = CurrencyManager.shared
  private let currencyImages = [
    "USD": "dollarsign.circle.fill",
    "EUR": "eurosign.circle.fill",
    "RUR": "rublesign.circle.fill",
    "BTC": "bitcoinsign.circle.fill"
  ]
  
  @Published var bankCurrencies: [Currency]?
  @Published var privat24Currencies: [Currency]?
  @Published var buyRate: Double?
  @Published var saleRate: Double?
  
  init() {
    self.currencyManager.delegate = self
  }
  
  private func updateCurrencyRate(_ id: Int, _ currencyType: CurrencyType) {
    var selectedCurrency: Currency?
    
    switch currencyType {
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
    return currencyImages[currency] ?? ""
  }
  
  func getSelectedCurrency(_ index: Int, currencyType: CurrencyType) -> String {
    updateCurrencyRate(index, currencyType)
    switch currencyType {
    case .bank:
      return bankCurrencies?[index].ccy ?? ""
    case .privat24:
      return privat24Currencies?[index].ccy ?? ""
    }
  }
}

extension ExchangePresenter: CurrencyManagerDelegate {
  func didUpdateCurrencies(data: [Currency], from: CurrencyType) {
    switch from {
    case .bank:
      self.bankCurrencies = data
      self.buyRate = Double(bankCurrencies?[0].buy ?? "")
      self.saleRate = Double(bankCurrencies?[0].sale ?? "")
    case .privat24:
      self.privat24Currencies = data
    }
  }
  
  func didFailWithError(message: String) {
    print(message)
  }
}
