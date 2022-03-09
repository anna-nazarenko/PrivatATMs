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
    self.currencyManager.fetchBankCurrency()
    self.currencyManager.fetchPrivat24Currency()
  }
}
