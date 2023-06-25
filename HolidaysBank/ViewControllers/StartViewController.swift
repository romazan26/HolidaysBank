//
//  ViewController.swift
//  HolidaysBank
//
//  Created by Роман on 19.06.2023.
//

import UIKit
import Alamofire

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
        AF.request(Link.holidayURL.url)
            .validate()
            .responseJSON { [weak self] dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    self?.holidays = Holiday.getHolidays(from: value)
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
