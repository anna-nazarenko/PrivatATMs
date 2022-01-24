//
//  ATMViewController.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 19.01.2022.
//

import UIKit

class CashMachinesViewController: UITableViewController {
    
    let networkManager = NetworkManager.shared
    var cashMachines = [Device]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        networkManager.fetchCashMachines()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cashMachines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ATMCell", for: indexPath)
        cell.textLabel?.text = cashMachines[indexPath.row].placeUa
        return cell
    }
}

//MARK: - Network Manager Delegate

extension CashMachinesViewController: NetworkManagerDelegate {
    func didUpdateData(_ networkManager: NetworkManager, data: [Device]) {
        DispatchQueue.main.async {
            self.cashMachines = data
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
