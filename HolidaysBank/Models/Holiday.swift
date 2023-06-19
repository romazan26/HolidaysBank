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
}
