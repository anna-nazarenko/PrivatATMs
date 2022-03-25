//
//  DetailsViewController.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 24.01.2022.
//

import UIKit
import Rswift

class DetailsViewController: UIViewController {
  
  //MARK: - Properties
  
  var device: Device?
  
  //MARK: - Outlets
  
  @IBOutlet weak var address: UILabel!
  @IBOutlet weak var workScheduleLabel: UILabel! {
    didSet {
      self.workScheduleLabel.text = R.string.localizable.detailsView_workSchedule()
    }
  }
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      self.tableView.dataSource = self
      self.tableView.delegate = self
      self.tableView.register(WorkingHoursCell.self)
    }
  }
  
  //MARK: - ViewController Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.loadData()
  }
  
  //MARK: - Data Manipulation Methods
  
  func loadData() {
    guard let deviceInfo = self.device else { return }
    self.address.text = deviceInfo.fullAddressUa
  }
}

//MARK: - TableView Datasource/Delegate Methods

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.device?.tw?.numberOfDays ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withType: WorkingHoursCell.self, for: indexPath)
    
    if let workingHoursInfo = self.device?.tw?.getWorkingHoursByDay(indexPath.row) {
      cell.configureCell(workingHoursByDay: workingHoursInfo)
    }
    
    return cell
  }
}
