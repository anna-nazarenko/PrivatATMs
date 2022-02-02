//
//  NetworkManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 20.01.2022.
//

import Foundation
import Alamofire

enum API {
    static let baseURL = "https://api.privatbank.ua/p24api/"
}

protocol NetworkManagerDelegate: AnyObject {
    func didUpdateData(_ networkManager: NetworkManager, data: Result)
    func didFailWithError(error: Error)
}

class NetworkManager {
    static let shared = NetworkManager(baseURL: API.baseURL)
    let baseUrl: String
    var preSavedDevices: Result?
    weak var delegate: NetworkManagerDelegate?

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
        AF.request(urlString)
            .validate()
            .responseDecodable(of: Result.self, decoder: JSONDecoder()) { response in
                switch response.result {
                case .success:
                    guard let resultData = response.value else { return }
                    self.delegate?.didUpdateData(self, data: resultData)
                    if self.preSavedDevices == nil { self.preSavedDevices = resultData }
                case .failure:
                    if let code = response.response?.statusCode {
                        NSLog("Received response: \(code) \(HTTPURLResponse.localizedString(forStatusCode: code))")
                    }
                }
            }
    }
    
    func cancelRequest() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
                    dataTasks.forEach { $0.cancel() }
                    uploadTasks.forEach { $0.cancel() }
                    downloadTasks.forEach { $0.cancel() }
                })
    }
}
