//
//  ExchangeView.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 21.02.2022.
//

import SwiftUI

//MARK: - Exchange View

struct ExchangeView: View {
  @StateObject var exchangePresenter = ExchangePresenter()
  @State var bankcCurrencyID = 0
  @State var currencyName = "USD"
  private let bankCurrencies = ["USD", "EUR", "BTC"]
  private let privat24Currencies = ["United States Dollar", "Euro", "Russian Ruble", "Bitcoin"]

  
  init() {
    UITableView.appearance().backgroundColor = .clear
  }
  
  var body: some View {
    VStack(alignment: .center) {
      
      ZStack {
        Color(UIColor(.cyan))
        
        VStack {
          Image(systemName: exchangePresenter.getImageName(by: currencyName))
            .resizable()
            .frame(width: 100, height: 100, alignment: .center)
            .foregroundColor(.yellow)
            .padding(25)
          
          HStack {
            VStack {
              SmallLabelView(text: "Buy")
              CurrencyRateView(rate: self.exchangePresenter.buyRate ?? 0)
            }
            
            VStack {
              SmallLabelView(text: "Sale")
              CurrencyRateView(rate: self.exchangePresenter.saleRate ?? 0)
            }
          }
          .frame(width: 350, height: 120)
        }
      }
      
      ZStack {
        Color(UIColor(.yellow))
        
        VStack {
          Text("Bank")
            .font(Font.custom("HelveticaNeue", size: 20))
            .padding(.vertical, 25)

          Picker(selection: $bankcCurrencyID, label: Text(bankCurrencies[bankcCurrencyID])) {
            ForEach(0 ..< bankCurrencies.count) {
              Text(bankCurrencies[$0])
            }
          }
          .pickerStyle(.segmented)
          .padding(.horizontal, 15)
          .onChange(of: bankcCurrencyID) { currencyID in
            self.exchangePresenter.updateCurrencyRate(id: currencyID, from: .bank)
            guard let selectedCurrency = exchangePresenter.bankCurrencies?[currencyID].ccy else { return }
            self.currencyName = selectedCurrency
          }
          
          Text("Privat24")
            .font(Font.custom("HelveticaNeue", size: 20))
            .padding(.top, 35)

          List(privat24Currencies.indices, id: \.self) { index in
            Text(privat24Currencies[index])
              .onTapGesture {
                self.exchangePresenter.updateCurrencyRate(id: index, from: .privat24)
                guard let selectedCurrency = exchangePresenter.privat24Currencies?[index].ccy else { return } //create func
                self.currencyName = selectedCurrency
              }
          }
          .onAppear(perform: {
              UITableView.appearance().contentInset.top = -25
          })
        }
      }
    }
    .edgesIgnoringSafeArea(.top)
    .environmentObject(exchangePresenter)
  }
}

//MARK: - Preview Provider

struct ExchangeView_Previews: PreviewProvider {
  static var previews: some View {
    ExchangeView()
  }
}

//MARK: - Small Label View

struct SmallLabelView: View {
  let text: String
  var body: some View {
    Text(text)
      .font(Font.custom("HelveticaNeue", size: 20))
      .foregroundColor(.white)
  }
}

//MARK: - Currency Rate View

struct CurrencyRateView: View {
  var rate: Double

  var body: some View {
    Text(String(format: "%.2f", rate))
      .font(Font.system(size: 55))
      .fontWeight(.regular)
      .foregroundColor(.white)
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 10)
      .minimumScaleFactor(0.5)
      .lineLimit(1)
      .frame(height: 75)
  }
}
