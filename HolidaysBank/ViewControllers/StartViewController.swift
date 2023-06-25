//
//  ViewController.swift
//  HolidaysBank
//
//  Created by Роман on 19.06.2023.
//

import UIKit

final class StartViewController: UIViewController {

    private var holidays: [Holiday] = []
    private let networkManager = NetworkManager.shared
    
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHoliday()
        startButton.pulsate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let holidayCVC = segue.destination as? HolidayCollectionViewController else {return}
        holidayCVC.holidays = holidays
    }
}
// MARK: extension ViewController
extension StartViewController {
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
// MARK: UIButton
extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.fromValue = 0.8
        pulse.toValue = 1
        pulse.duration = 0.6
        pulse.autoreverses = true
        pulse.repeatCount = 10
        pulse.initialVelocity = 0.5
        pulse.damping = 5
        layer.add(pulse, forKey: nil)
    }
}
