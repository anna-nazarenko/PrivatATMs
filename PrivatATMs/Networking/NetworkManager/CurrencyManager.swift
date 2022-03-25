//
//  CurrencyManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 23.02.2022.
//

import Foundation
import Alamofire

//MARK: - Currency Manager Delegate

protocol CurrencyManagerDelegate: AnyObject {
  func didUpdateCurrencies(data: [Currency], from: CurrencyType)
  func didFailWithError(message: String)
}

//MARK: - Currency Manager

class CurrencyManager {
  static let shared = CurrencyManager()
  weak var delegate: CurrencyManagerDelegate?
  var request: DataRequest?
  
  private init() {}
  
  func fetchBankCurrency() {
    let stringURL = "\(API.baseURL.rawValue)\(API.bankCurrencyPath.rawValue)"
    perfomCurrencyRequest(with: stringURL, requestType: CurrencyType.bank)
  }
  
  func fetchPrivat24Currency() {
    let stringURL = "\(API.baseURL.rawValue)\(API.privat24CurrencyPath.rawValue)"
    perfomCurrencyRequest(with: stringURL, requestType: CurrencyType.privat24)
  }
  
  func perfomCurrencyRequest(with urlString: String, requestType: CurrencyType) {
    self.request = AF.request(urlString)
      .validate()
      .responseDecodable(of: [Currency].self, decoder: JSONDecoder()) { response in

        switch response.result {
        case .success:
          guard let resultData = response.value else { return }
          self.delegate?.didUpdateCurrencies(data: resultData, from: requestType)
          
        case .failure:
          if let code = response.response?.statusCode {
            let errorString = "Received response: \(code) \(HTTPURLResponse.localizedString(forStatusCode: code))"
            self.delegate?.didFailWithError(message: errorString)
            print("didFailWithError")
          }
        }
      }
  }
}
