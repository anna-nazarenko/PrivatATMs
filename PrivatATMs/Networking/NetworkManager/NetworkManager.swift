//
//  NetworkManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 20.01.2022.
//

import Foundation
import Alamofire

//MARK: - API

enum API: String {
  case baseURL = "https://api.privatbank.ua/p24api/"
  case cityPath = "infrastructure?json&tso&city="
  case bankCurrencyPath = "pubinfo?json&exchange&coursid=5"
  case privat24CurrencyPath = "pubinfo?exchange&json&coursid=11"
}

//MARK: - Default Cities

enum DefaultCities: String {
  case cityLviv = "Львів"
}

//MARK: - Network Manager Delegate

protocol NetworkManagerDelegate: AnyObject {
  func didUpdateData(data: [Device], isInitiaRequest: Bool)
  func didFailWithError(message: String)
}

//MARK: - Properties

class NetworkManager {
  static let shared = NetworkManager()
  weak var delegate: NetworkManagerDelegate?
  var request: DataRequest?
  
  private init() {}
}

//MARK: - Fetch Cash Machines Methods

extension NetworkManager {
  
  func fetchCashMachines() {
    guard let stringURL = "\(API.baseURL.rawValue)\(API.cityPath.rawValue)\(DefaultCities.cityLviv.rawValue)".percentEncode() else { return }
    performRequest(with: stringURL, isInitiaRequest: true)
  }
  
  func fetchCashMachine(cityName: String) {
    guard let stringURL = "\(API.baseURL.rawValue)\(API.cityPath.rawValue)\(cityName)".percentEncode() else { return }
    performRequest(with: stringURL, isInitiaRequest: false)
  }
  
  func performRequest(with urlString: String, isInitiaRequest: Bool) {
    self.request = AF.request(urlString)
      .validate()
      .responseDecodable(of: Result.self, decoder: JSONDecoder()) { response in
        
        switch response.result {
          
        case .success:
          guard let resultData = response.value else { return }
          self.delegate?.didUpdateData(data: resultData.devices, isInitiaRequest: isInitiaRequest)
          
        case .failure:
          if let code = response.response?.statusCode {
            let errorString = "Received response: \(code) \(HTTPURLResponse.localizedString(forStatusCode: code))"
            self.delegate?.didFailWithError(message: errorString)
          }
        }
      }
  }
  
  func cancelRequest() {
    self.request?.cancel()
  }
}
