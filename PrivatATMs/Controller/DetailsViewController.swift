//
//  DetailsViewController.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 24.01.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var address: UILabel!
    
    var deviceDetails: Device?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    func loadData() {
        if let addressUA = deviceDetails?.fullAddressUa {
            address.text = addressUA
        }
    }
}
