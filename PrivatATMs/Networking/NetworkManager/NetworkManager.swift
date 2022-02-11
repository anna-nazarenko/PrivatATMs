//
//  NetworkManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 20.01.2022.
//

import Foundation
import Alamofire
import UIKit

enum API {
    static let baseURL = "https://api.privatbank.ua/p24api/"
}

protocol NetworkManagerDelegate: AnyObject {
    func didUpdateData(_ networkManager: NetworkManager, data: [Device])
    func didFailWithError(message: String)
}

class NetworkManager {
    static let shared = NetworkManager(baseURL: API.baseURL)
    let baseUrl: String
    weak var delegate: NetworkManagerDelegate?
    var request: DataRequest?

    private init(baseURL: String) {
        self.baseUrl = baseURL
    }
    
    func fetchCashMachines() {
        let stringURL = "\(baseUrl)infrastructure?json&tso&city=Львів".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        performRequest(with: stringURL)
    }
    
    func fetchCashMachine(cityName: String) {
        let stringURL = "\(baseUrl)infrastructure?json&tso&city=\(cityName)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        performRequest(with: stringURL)
    }
    
    func performRequest(with urlString: String) {
        request = AF.request(urlString)
            .validate()
            .responseDecodable(of: Result.self, decoder: JSONDecoder()) { response in
                
                switch response.result {
                case .success:
                    guard let resultData = response.value else { return }
                    self.delegate?.didUpdateData(self, data: resultData.devices)
                case .failure:
                    if let code = response.response?.statusCode {
                        let errorString = "Received response: \(code) \(HTTPURLResponse.localizedString(forStatusCode: code))"
                        self.delegate?.didFailWithError(message: errorString)
                        
                    }
                }
            }
    }
    
    func cancelRequest() {
        request?.cancel()
    }
}
