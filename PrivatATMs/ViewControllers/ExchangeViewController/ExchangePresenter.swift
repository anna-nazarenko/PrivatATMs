//
//  ExchangePresenter.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 23.02.2022.
//

import Foundation

//MARK: - Currency Type

enum CurrencyType: String {
  case bank
  case privat24
}

//MARK: - Exchange Presenter

class ExchangePresenter: ObservableObject  {
  
  //MARK: - Properties
  
  private let currencyManager = CurrencyManager.shared
  
  @Published var bankCurrencies: [Currency] = []
  @Published var privat24Currencies: [Currency] = []
  @Published var buyRate: Double?
  @Published var saleRate: Double?
  
  init() {
    self.currencyManager.delegate = self
  }
  
  //MARK: - Methods
  
  private func saveInitialCurrencyRate(buy: String?, sale: String?) {
    self.buyRate = Double(buy ?? "")
    self.saleRate = Double(sale ?? "")
  }
  
  func updateCurrencyRate(_ id: Int, _ currencyType: CurrencyType) {
    var selectedCurrency: Currency?
    
    switch currencyType {
      case .bank: selectedCurrency = bankCurrencies[id]
      case .privat24: selectedCurrency = privat24Currencies[id]
    }
    
    if let currency = selectedCurrency {
      buyRate = Double(currency.buy)
      saleRate = Double(currency.sale)
    }
  }
}

//MARK: - Currency Manager Delegate

extension ExchangePresenter: CurrencyManagerDelegate {
  func didUpdateCurrencies(data: [Currency], from: CurrencyType) {
    switch from {
    case .bank:
      self.bankCurrencies = data
      saveInitialCurrencyRate(buy: bankCurrencies.first?.buy, sale: bankCurrencies.first?.sale)
    case .privat24:
      self.privat24Currencies = data
    }
  }
  
  func didFailWithError(message: String) {
    print(message)
  }
}
