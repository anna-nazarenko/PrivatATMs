//
//  NetworkManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 20.01.2022.
//

import Foundation
import UIKit

enum API {
    static let baseURL = "https://api.privatbank.ua/p24api/"
}

protocol NetworkManagerDelegate: AnyObject {
    func didUpdateData(_ networkManager: NetworkManager, data: [Device])
    func didFailWithError(error: Error)
}

class NetworkManager {
    static let shared = NetworkManager(baseURL: API.baseURL)
    let baseUrl: String
    var devices: [Device]?
    weak var delegate: NetworkManagerDelegate?

    private init(baseURL: String) {
        self.baseUrl = baseURL
    }
    
    func fetchCashMachines() {
        let stringURL = "\(baseUrl)infrastructure?json&tso&address=&city=Львів".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        performRequest(with: stringURL)
    }
    
    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Error with constructing URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, responce, error in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            
            if let safeData = data, let results = self.parseJSON(safeData) {
                self.delegate?.didUpdateData(self, data: results)
            }
        }
        
        task.resume()
    }
    
    func parseJSON(_ resultData: Data) -> [Device]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Result.self, from: resultData)
            self.devices = decodedData.devices
            return devices
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
