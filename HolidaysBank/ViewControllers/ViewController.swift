//
//  ViewController.swift
//  HolidaysBank
//
//  Created by Роман on 19.06.2023.
//

import UIKit

final class ViewController: UIViewController {

    var holidays: [Holiday] = []
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHoliday()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let holidayCVC = segue.destination as? HolidayCollectionViewController else {return}
        holidayCVC.holidays = holidays
    }
    

}
extension ViewController {
    private func fetchHoliday() {
        networkManager.fetch([Holiday].self, from: Link.holidayURL.url) { [weak self] result in
            switch result {
            case .success( let holidaysys):
                self?.holidays = holidaysys
            case .failure(let error):
                print(error)
           
            }
        }
        
    }
}
