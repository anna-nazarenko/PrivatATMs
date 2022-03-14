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
    self.currencyManager.fetchBankCurrency()
    self.currencyManager.fetchPrivat24Currency()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    print("viewDidLayoutSubviews")
    
    addSwiftUI()
//    addSwiftUIView(ExchangeView(), to: view)
  }
  
  fileprivate func addSwiftUI() {
    let hostingController = UIHostingController(rootView: ExchangeView())
    
    addChild(hostingController)
    view.addSubview(hostingController.view)
    hostingController.didMove(toParent: self)
    
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    
    let constraints = [
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hostingController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
}
