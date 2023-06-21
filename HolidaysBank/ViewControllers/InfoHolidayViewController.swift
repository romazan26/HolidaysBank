//
//  InfoHolidayViewController.swift
//  HolidaysBank
//
//  Created by Роман on 21.06.2023.
//

import UIKit

final class InfoHolidayViewController: UIViewController {
    var hoilday: Holiday!
    
    @IBOutlet var infoHolidayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfoHoliday()
        
    }
    
    private func getInfoHoliday() {
        infoHolidayLabel.text = """
                Data: \(hoilday.date)
                Local name: \(hoilday.localName)
                name: \(String(format: "%.02f", hoilday.name))
                """
    }
}
