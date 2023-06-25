//
//  Holiday.swift
//  HolidaysBank
//
//  Created by Роман on 19.06.2023.
//

import Foundation

struct Holiday: Decodable {
    let localName: String
    let name: String
    let date: String
    
    init(holidayData: [String: Any]) {
    localName = holidayData["localName"] as? String ?? ""
    name = holidayData["name"] as? String ?? ""
    date = holidayData["date"] as? String ?? ""
    }
    
    init(localName: String, name: String, date: String){
        self.name = name
        self.localName = localName
        self.date = date
    }
    
    static func getHolidays(from value: Any) -> [Holiday] {
        guard let holidaysData = value as? [[String: Any]] else { return [] }
        
        return holidaysData.map {Holiday(holidayData: $0)}
    }
}

