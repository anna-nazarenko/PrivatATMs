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
  func addSwiftUIView<Content>(_ swiftUIView: Content, to view: UIView) where Content: View {
    let hostingController = UIHostingController(rootView: swiftUIView)
    
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

//MARK: - Navigation Methods

extension UIViewController {
  enum NavigationType {
    case push
    case present
    case pop
  }
  
  func navigate(_ viewController: UIViewController, type: NavigationType, animated: Bool = true) {
    guard let navigation = self.navigationController else {
      print("No Navigation Controller")
      return
    }
    
    switch type {
      case .push: navigation.pushViewController(viewController, animated: animated)
      case .present: navigation.present(viewController, animated: animated, completion: nil)
      case .pop: navigation.popViewController(animated: animated)
    }
  }
}


