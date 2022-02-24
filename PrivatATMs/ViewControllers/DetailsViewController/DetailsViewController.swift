//
//  DetailsViewController.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 24.01.2022.
//

import UIKit

class DetailsViewController: UIViewController {
  
  @IBOutlet weak var address: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  var device: Device?
  
  
  //MARK: - ViewController Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
    self.tableView.dataSource = self
    self.tableView.register(UINib(nibName: "WorkingHoursCell", bundle: nil), forCellReuseIdentifier: "WorkingHoursCell")
  }
  
  //MARK: - Data Manipulation Methods
  
  func loadData() {
    guard let deviceInfo = self.device else { return }
    self.address.text = deviceInfo.fullAddressUa
  }
}

//MARK: - TableView Datasource/Delegate Methods

extension DetailsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.device?.tw?.numberOfDays ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WorkingHoursCell", for: indexPath) as! WorkingHoursCell
    
    if let workingHoursInfo = self.device?.tw?.getWorkingHoursByDay(indexPath.row) {
      cell.configureCell(workingHoursByDay: workingHoursInfo)
    }
    
    return cell
  }
}
