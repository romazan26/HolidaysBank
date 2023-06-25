//
//  NetworkManager.swift
//  HolidaysBank
//
//  Created by Роман on 21.06.2023.
//

import Foundation
import Alamofire

enum Link {
    case holidayURL
    case pictureURL
    
    var url: URL {
        switch self {
        case .holidayURL:
            return URL(string: "https://date.nager.at/api/v2/publicholidays/2020/US")!
        case .pictureURL:
            return URL(string: "https://balashover.ru/picture/news/40228_b12b7fae66a4c6fd169cf536c8457f48.png")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init () {}
   
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    func fetchHolidays(from url: URL, completion: @escaping(Result<[Holiday], AFError>) -> Void){
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let holidays = Holiday.getHolidays(from: value)
                    completion(.success(holidays))
                    
                case .failure(let error):
                    completion(.failure(error))
                    
                }
            }
    }
   
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
