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
  private let bankCurrencies = ["United States Dollar", "Euro", "Bitcoin"]
  private let privat24Currencies = ["United States Dollar", "Euro", "Russian Ruble", "Bitcoin"]
  
  var body: some View {
    VStack(alignment: .center) {
      
      ZStack {
        Color(UIColor(.cyan))
        
        VStack {
          CurrencyIcon(name: exchangePresenter.getImageName(by: currencyName))
          
          HStack {
            VStack {
              SmallLabelView(text: "ExchangeView_buy")
              CurrencyRateView(rate: self.exchangePresenter.buyRate ?? 0)
            }
            
            VStack {
              SmallLabelView(text: "ExchangeView_sale")
              CurrencyRateView(rate: self.exchangePresenter.saleRate ?? 0)
            }
          }
          .frame(width: 350, height: 120)
        }
      }
      .frame(maxHeight: 350)

      VStack {
        List {
          Section(LocalizedStringKey("ExchangeView_bank")) {
            ForEach(bankCurrencies.indices, id: \.self) { index in
              Button(bankCurrencies[index]) {
                self.currencyName = self.exchangePresenter.getSelectedCurrency(index, currencyType: .bank)
              }
              .foregroundColor(.black)
            }
          }
          
          Section(LocalizedStringKey("ExchangeView_privat24")) {
            ForEach(privat24Currencies.indices, id: \.self) { index in
              Button(privat24Currencies[index]) {
                self.currencyName = self.exchangePresenter.getSelectedCurrency(index, currencyType: .privat24)
              }
              .foregroundColor(.black)
            }
          }
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

//MARK: - Currency Icon

struct CurrencyIcon: View {
  let name: String
  var body: some View {
    Image(systemName: name)
      .resizable()
      .frame(width: 100, height: 100, alignment: .center)
      .foregroundColor(.yellow)
      .padding(25)
      .padding(.top, 40)
  }
}

//MARK: - Small Label View

struct SmallLabelView: View {
  let text: LocalizedStringKey
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
