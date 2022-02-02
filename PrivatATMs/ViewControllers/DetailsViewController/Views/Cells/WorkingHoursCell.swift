//
//  WorkingHoursCell.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 25.01.2022.
//

import UIKit

class WorkingHoursCell: UITableViewCell {

    @IBOutlet private weak var dayOfWeek: UILabel!
    @IBOutlet weak var workingHours: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(workingHoursByDay: Schedule.WorkingHoursByDay) {
        dayOfWeek.text = workingHoursByDay.day
        workingHours.text = workingHoursByDay.hours
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayOfWeek.text = nil
        workingHours.text = nil
    }
}
