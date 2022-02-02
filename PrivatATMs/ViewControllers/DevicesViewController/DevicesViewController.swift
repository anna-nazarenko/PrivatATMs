//
//  ATMViewController.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 19.01.2022.
//

import UIKit

protocol CashMachineViewControllerProtocol {
    func pushDetailsVC()
}

class DevicesViewController: UITableViewController {
    let networkManager = NetworkManager.shared
    private var result: Result?
    
//MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        networkManager.fetchCashMachines()
    }
}

//MARK: - TableView Datasource/Delegate Methods

extension DevicesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.devices.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ATMCell", for: indexPath)
        cell.textLabel?.text = result?.devices[indexPath.row].placeUa
        return cell
    }
    
//MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushDetailsVC()
    }
}

//MARK: - Network Manager Delegate Methods

extension DevicesViewController: NetworkManagerDelegate {
    func didUpdateData(_ networkManager: NetworkManager, data: Result) {
        DispatchQueue.main.async {
            self.result = data
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension DevicesViewController: CashMachineViewControllerProtocol {
    func pushDetailsVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            detailsVC.device = result?.devices[indexPath.row]
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
