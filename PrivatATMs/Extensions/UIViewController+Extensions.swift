//
//  UIViewController+Extensions.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 09.02.2022.
//

import UIKit

fileprivate var activityIndicator: UIActivityIndicatorView?

extension UIViewController {

    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        
        guard let activityIndicator = activityIndicator else { return }
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(activityIndicator)
        
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
