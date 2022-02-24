//
//  UIViewController+Extensions.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 09.02.2022.
//

import UIKit
import SwiftUI

fileprivate var activityIndicator: UIActivityIndicatorView?

//MARK: - Activity Indicator Methods

extension UIViewController {
  
  func addActivityIndicator() {
    activityIndicator = UIActivityIndicatorView()
    
    guard let activityIndicator = activityIndicator else { return }
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(activityIndicator)
    
    activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    activityIndicator.hidesWhenStopped = true
    activityIndicator.startAnimating()
  }
  
  func removeActivityIndicator() {
    activityIndicator?.stopAnimating()
    activityIndicator?.removeFromSuperview()
  }
}

//MARK: - Adding SwiftUI View Method

extension UIViewController {
  func addSwiftUIView<Content>(_ swiftUIView: Content, to view: UIView) where Content : View {
    let hostingController = UIHostingController(rootView: swiftUIView)
    
    addChild(hostingController)
    view.addSubview(hostingController.view)
    
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    
    let constraints = [
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
      view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
      view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
    ]
    
    NSLayoutConstraint.activate(constraints)
    
    hostingController.didMove(toParent: self)
  }
}
