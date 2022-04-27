//
//  ExchangeViewController.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 19.01.2022.
//

import UIKit
import SwiftUI

class ExchangeViewController: UIViewController {
  
  //MARK: - Exchange View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    addSwiftUIView(ExchangeView(), to: view)
  }
}
