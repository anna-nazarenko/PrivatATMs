//
//  ATMViewController.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 19.01.2022.
//

import UIKit

//MARK: - Devices View Controller Protocol

protocol DevicesViewControllerProtocol {
  func pushDetailsVC()
  func reloadData()
  func showSpinner()
  func hideSpinner()
}

class DevicesViewController: UITableViewController {
  private var devicesPresenter: DevicePresenterProtocol?
  
  
  //MARK: - ViewController Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.devicesPresenter = DevicePresenter(self)
    self.devicesPresenter?.getDevices()    
  }
}

//MARK: - TableView Datasource/Delegate Methods

extension DevicesViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.devicesPresenter?.devices?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ATMCell", for: indexPath)
    
    if let devices = self.devicesPresenter?.devices {
      cell.textLabel?.text = devices[indexPath.row].placeUa
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    pushDetailsVC()
  }
}

//MARK: - Search Bar Delegate Methods

extension DevicesViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let searchBarText = searchBar.text, !searchBarText.isEmpty {
      self.devicesPresenter?.getDevices(byCity: searchBarText)
    }
    searchBar.resignFirstResponder()
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard let searchBarText = searchBar.text else { return }
    
    if searchBarText.count < 3 {
      self.devicesPresenter?.updateTableViewWithPreSavedDevices()
    } else {
      self.devicesPresenter?.cancelRequest()
      self.devicesPresenter?.getDevices(byCity: searchBarText)
    }
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
  }
}

//MARK: - Devices View Controller Protocol Methods

extension DevicesViewController: DevicesViewControllerProtocol {
  func reloadData() {
    self.tableView.reloadData()
  }
  
  func showSpinner() {
    self.addActivityIndicator()
  }
  
  func hideSpinner() {
    self.removeActivityIndicator()
  }
  
  func pushDetailsVC() {
    guard let vc = R.storyboard.details.detailsVC() else { return }
    
    if let indexPath = tableView.indexPathForSelectedRow, let devices = self.devicesPresenter?.devices {
      vc.device = devices[indexPath.row]
    }
    
    self.navigate(vc, type: .push)
  }
}
