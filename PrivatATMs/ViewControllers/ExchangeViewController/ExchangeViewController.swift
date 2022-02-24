//
//  ExchangeViewController.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 19.01.2022.
//

import UIKit
import SwiftUI

class ExchangeViewController: UIViewController {
  
  let currencyManager = CurrencyManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addSwiftUIView(ExchangeView(), to: view)
    self.currencyManager.delegate = self
    self.currencyManager.fetchBankCurrency()
  }
}

extension ExchangeViewController: CurrencyManagerDelegate {
  func didUpdateCurrencies(data: [Currency]) {
    //        print(data)
  }
  
  func didFailWithError(message: String) {
    print(message)
  }
}
