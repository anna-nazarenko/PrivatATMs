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
    
    var deviceDetails: Device?
    var daysOfWeek = [""]
    var workingHours = [""]

    
//MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WorkingHoursCell", bundle: nil), forCellReuseIdentifier: "WorkingHoursCell")
    }
    
//MARK: - Data Manipulation Methods
    
    func loadData() {
        guard let deviceInfo = deviceDetails else { return }
        address.text = deviceInfo.fullAddressUa
        daysOfWeek = ["Понеділок", "Вівторок", "Середа", "Четверг", "П'ятниця", "Субота", "Неділя", "Вихідні"]
        workingHours = [deviceInfo.tw.mon, deviceInfo.tw.tue, deviceInfo.tw.wed, deviceInfo.tw.thu, deviceInfo.tw.fri, deviceInfo.tw.sat,deviceInfo.tw.sun, deviceInfo.tw.hol]
    }
}

//MARK: - TableView Datasource/Delegate Methods

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceDetails?.tw.days ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkingHoursCell", for: indexPath) as! WorkingHoursCell
        
        cell.workingHours.text = workingHours[indexPath.row]
        
        cell.configureCell(day: daysOfWeek[indexPath.row])
        
        return cell
    }
}
