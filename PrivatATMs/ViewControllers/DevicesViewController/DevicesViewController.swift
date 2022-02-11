//
//  ATMViewController.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 19.01.2022.
//

import UIKit

protocol DevicesViewControllerProtocol {
    func pushDetailsVC()
    func reloadData()
    func showSpinner()
    func hideSpinner()
}

class DevicesViewController: UITableViewController {
    
    private let devicesPresenter = DevicesPresenter()
    
//MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.devicesPresenter.setDevicesViewController(self)
        self.devicesPresenter.getDevices()
    }
}

//MARK: - TableView Datasource/Delegate Methods

extension DevicesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.devicesPresenter.devices?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ATMCell", for: indexPath)
        if let devices = self.devicesPresenter.devices {
            cell.textLabel?.text = devices[indexPath.row].placeUa
        }
        return cell
    }
    
//MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushDetailsVC()
    }
}

//MARK: - Search Bar Delegate Methods

extension DevicesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchBarText = searchBar.text, !searchBarText.isEmpty {
            devicesPresenter.getDevices(byCity: searchBarText)
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchBarText = searchBar.text else { return }

        if searchBarText.count < 3 {
            self.devicesPresenter.updateTableViewWithPreSavedDevices()
        } else {
            self.devicesPresenter.cancelRequest()
            self.devicesPresenter.getDevices(byCity: searchBarText)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

//MARK: - Devices View Controller Protocol

extension DevicesViewController: DevicesViewControllerProtocol {
    func reloadData() {
        tableView.reloadData()
    }
    
    func showSpinner() {
        self.addActivityIndicator()
    }
    
    func hideSpinner() {
        self.removeActivityIndicator()
    }
    
    func pushDetailsVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsViewController
        if let indexPath = tableView.indexPathForSelectedRow, let devices = self.devicesPresenter.devices {
            detailsVC.device = devices[indexPath.row]
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
