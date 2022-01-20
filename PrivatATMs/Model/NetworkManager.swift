//
//  NetworkManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 20.01.2022.
//

import Foundation

class NetworkManager {
    
    var urlString = "https://api.privatbank.ua/p24api/infrastructure?json&tso&address=&city=Львів".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    var results: Result?

    func fetchCashMachines() {
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, responce, error in
                if error != nil {
                    print("Error with retrieving data: \(String(describing: error))")
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(safeData)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ resultData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Result.self, from: resultData)
            DispatchQueue.main.async {
                self.results = decodedData
                print(self.results ?? "nil")
            }
        } catch {
            print("Error with decoding data: \(error)")
        }
    }
}
