//
//  CurrencyManager.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 23.02.2022.
//

import Foundation
import Alamofire

protocol CurrencyManagerDelegate: AnyObject {
  func didUpdateCurrencies(data: [Currency])
  func didFailWithError(message: String)
}

class CurrencyManager {
  static let shared = CurrencyManager()
  weak var delegate: CurrencyManagerDelegate?
  var request: DataRequest?
  
  private init() {}
  
  func fetchBankCurrency() {
    //let stringURL = "\(API.baseURL.rawValue)\(API.bankCurrencyPath.rawValue)"
    let stringURL = "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5"
    perfomCurrencyRequest(with: stringURL)
  }
  
  func fetchPrivat24Currency() {
    let stringURL = "https://api.privatbank.ua/p24api/pubinfo?exchange&json&coursid=11"
    //    let stringURL = "\(API.baseURL.rawValue)\(API.privat24CurrencyPath.rawValue)"
    perfomCurrencyRequest(with: stringURL)
  }
  
  func perfomCurrencyRequest(with urlString: String) {
    self.request = AF.request(urlString)
      .validate()
      .responseDecodable(of: [Currency].self, decoder: JSONDecoder()) { response in
        
        print(response.value)
        
        switch response.result {
          
        case .success:
          guard let resultData = response.value else { return }
          self.delegate?.didUpdateCurrencies(data: resultData)
          
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
