//
//  ATMViewController.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 19.01.2022.
//

import UIKit

class CashMachinesViewController: UITableViewController {
    
    let cashMachines = ["One", "Two", "Three", "Four"]
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello")
        networkManager.fetchCashMachines()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cashMachines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ATMCell", for: indexPath)
        cell.textLabel?.text = cashMachines[indexPath.row]
        return cell
    }
    
}
