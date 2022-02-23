//
//  ExchangeViewController.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 19.01.2022.
//

import UIKit
import SwiftUI

class ExchangeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiftUIView(ExchangeView(), to: view)
    }
}
