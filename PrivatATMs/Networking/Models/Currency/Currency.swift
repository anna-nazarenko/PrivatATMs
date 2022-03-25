//
//  Currrency.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 23.02.2022.
//

import Foundation
import Rswift

typealias currencies = Currency.CurrencyType

//MARK: - Currency Model

struct Currency: Codable {
  var ccy: String
  var base_ccy: String
  var buy: String
  var sale: String
}

//MARK: - Currency Model Extension

extension Currency {
  enum CurrencyType: String {
    case usd = "USD"
    case eur = "EUR"
    case rur = "RUR"
    case btc = "BTC"
    case unknowed
    
    var currencyImage: CurrencyIcon {
      switch self {
        case .usd: return CurrencyIcon(name: .usdIcon)
        case .eur: return CurrencyIcon(name: .eurIcon)
        case .rur: return CurrencyIcon(name: .rurIcon)
        case .btc: return CurrencyIcon(name: .btcIcon)
        case .unknowed: return CurrencyIcon(name: .unknowedIcon)
      }
    }
  }
  
  var currentCurrency: CurrencyType {
    CurrencyType(rawValue: ccy) ?? .unknowed
  }
  
  var fullCurrencyName: String {
    switch currentCurrency {
      case .usd: return R.string.localizable.currency_usd()
      case .eur: return R.string.localizable.currency_eur()
      case .rur: return R.string.localizable.currency_rur()
      case .btc: return R.string.localizable.currency_btc()
      case .unknowed: return R.string.localizable.currency_unknowed()
    }
  }
}

//MARK: - System Icon Names

fileprivate extension String {
  static let usdIcon = "dollarsign.circle.fill"
  static let eurIcon = "eurosign.circle.fill"
  static let rurIcon = "rublesign.circle.fill"
  static let btcIcon = "bitcoinsign.circle.fill"
  static let unknowedIcon = "banknote.fill"
}
