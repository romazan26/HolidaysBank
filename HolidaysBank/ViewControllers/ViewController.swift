//
//  ViewController.swift
//  HolidaysBank
//
//  Created by Роман on 19.06.2023.
//

import UIKit

class ViewController: UIViewController {

    let url = URL(string: "https://date.nager.at/api/v2/publicholidays/2020/US")!
    var holidays: [Holiday]!
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
        URLSession.shared.dataTask(with: url) { data, respone, error in
            guard let data else {
                print(error ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                self.holidays = try decoder.decode([Holiday].self, from: data)
            } catch {
                print(error.localizedDescription)
                
            }
        }.resume()
    }
}
