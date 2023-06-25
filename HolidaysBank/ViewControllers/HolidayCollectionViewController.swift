//
//  HolidayCollectionViewController.swift
//  HolidaysBank
//
//  Created by Роман on 20.06.2023.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

final class HolidayCollectionViewController: UICollectionViewController {
    
    var holidays: [Holiday]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let infoHolidayVC = segue.destination as? InfoHolidayViewController else {return}
        infoHolidayVC.hoilday = sender as? Holiday
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        holidays.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "holidayAction", for: indexPath) as? HolidayCell else { return UICollectionViewCell() }
        cell.Label.text = holidays[indexPath.item].localName
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let holiday = holidays[indexPath.item]
        performSegue(withIdentifier: "holidayInfo", sender: holiday)
    }

}
// MARK: extension HolidayCollectionViewController
extension HolidayCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
