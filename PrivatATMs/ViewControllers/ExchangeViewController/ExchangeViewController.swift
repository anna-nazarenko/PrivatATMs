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
  
  //MARK: - Exchange View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.currencyManager.fetchBankCurrency()
    self.currencyManager.fetchPrivat24Currency()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    addSwiftUIView(ExchangeView(), to: view)
  }
}
