//
//  ExchangeView.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 21.02.2022.
//

import SwiftUI
import Combine

struct ExchangeView: View {
  @StateObject var exchangePresenter = ExchangePresenter()
  @State var bankcCurrencyID = 0
  @State var privat24CurrencyID = 0
  private let bankCurrencies = ["USD", "EUR", "BTC"]
  private let privat24Currencies = ["USD", "EUR", "RUR", "BTC"]
  
  var body: some View {
    
    VStack(alignment: .center) {
      
      ZStack {
        Color(UIColor(.cyan))
        
        VStack {
          Image(systemName: "dollarsign.circle.fill")
            .resizable()
            .frame(width: 100, height: 100, alignment: .center)
            .foregroundColor(.yellow)
            .padding(25)
          
          HStack {
            VStack {
              Text("Buy")
                .font(Font.custom("HelveticaNeue", size: 25))
                .foregroundColor(.white)
              
              Text(String(format: "%.2f", self.exchangePresenter.buyRate ?? 0))
                .font(Font.system(size: 55))
                .fontWeight(.regular)
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 1)
                .scaledToFill()
            }
            
            VStack {
              Text("Sale")
                .font(Font.custom("HelveticaNeue", size: 25))
                .foregroundColor(.white)
              Text(String(format: "%.2f", self.exchangePresenter.saleRate ?? 0))
                .font(Font.system(size: 55))
                .fontWeight(.regular)
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 1)
                .scaledToFill()
            }
          }
        }
      }
      
      ZStack {
        Color(UIColor(.yellow))
        
        VStack {
          Text("Bank")
            .font(Font.custom("HelveticaNeue", size: 20))

          Picker(selection: $bankcCurrencyID, label: Text(bankCurrencies[bankcCurrencyID])) {
            ForEach(0 ..< bankCurrencies.count) {
              Text(bankCurrencies[$0])
            }
          }
          .onChange(of: bankcCurrencyID, perform: { currencyID in
            print(currencyID)
            self.exchangePresenter.updateCurrencyRate(id: currencyID)
          })
          .pickerStyle(.segmented)
          .padding(15)
          
          Text("Privat24")
            .font(Font.custom("HelveticaNeue", size: 20))
            .padding(.top, 45)
          
          Picker(selection: $privat24CurrencyID, label: Text(privat24Currencies[privat24CurrencyID])) {
            ForEach(privat24Currencies, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.segmented)
          .padding(15)
        }
      }
    }
    .edgesIgnoringSafeArea(.top)
    .environmentObject(exchangePresenter)
  }
}

struct ExchangeView_Previews: PreviewProvider {
  static var previews: some View {
    ExchangeView()
  }
}
