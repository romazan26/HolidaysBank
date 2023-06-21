//
//  InfoHolidayViewController.swift
//  HolidaysBank
//
//  Created by Роман on 21.06.2023.
//

import UIKit

final class InfoHolidayViewController: UIViewController {
    var hoilday: Holiday!
    let networkManager = NetworkManager.shared
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var infoHolidayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        getInfoHoliday()
        fetchImage()
        
    }
    
    private func getInfoHoliday() {
        infoHolidayLabel.text = """
                Data: \(hoilday.date)
                Local name: \(hoilday.localName)
                name: \(hoilday.name)
                """
    }
    private func fetchImage() {
        networkManager.fetchImage(from: Link.newYearURL.url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
