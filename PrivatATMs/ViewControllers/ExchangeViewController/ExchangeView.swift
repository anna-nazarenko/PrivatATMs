//
//  ExchangeView.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 21.02.2022.
//

import SwiftUI

//MARK: - Exchange View

struct ExchangeView: View {
  
  //MARK: - Properties
  
  @StateObject var exchangePresenter = ExchangePresenter()
  @State var currencyType = currencies.usd
  let currencyManager = CurrencyManager.shared
  
  //MARK: - Body
  
  var body: some View {
    VStack(alignment: .center) {
      
      //MARK: - Currency Rate View
      
      ZStack {
        Color("currencyBackgroundColor")
        VStack {
          self.currencyType.currencyImage
          
          HStack {
            VStack {
              SmallTextView(text: R.string.localizable.exchangeView_buy())
              LargeTextView(rate: self.exchangePresenter.buyRate ?? 0)
            }
            
            VStack {
              SmallTextView(text: R.string.localizable.exchangeView_sale())
              LargeTextView(rate: self.exchangePresenter.saleRate ?? 0)
            }
          }
          .frame(width: 350, height: 120)
        }
      }
      .frame(maxHeight: 350)
      
      //MARK: - Currency List View

      VStack {
        List {
          Section(R.string.localizable.exchangeView_bank()) {
            ForEach(self.exchangePresenter.bankCurrencies.indices, id: \.self) { index in
              Button(self.exchangePresenter.bankCurrencies[index].fullCurrencyName) {
                self.currencyType = self.exchangePresenter.bankCurrencies[index].currentCurrency
                self.exchangePresenter.updateCurrencyRate(index, .bank)
              }
              .foregroundColor(.primary)
            }
          }
          
          Section(R.string.localizable.exchangeView_privat24()) {
            ForEach(self.exchangePresenter.privat24Currencies.indices, id: \.self) { index in
              Button(self.exchangePresenter.privat24Currencies[index].fullCurrencyName) {
                self.currencyType = self.exchangePresenter.privat24Currencies[index].currentCurrency
                self.exchangePresenter.updateCurrencyRate(index, .privat24)
              }
              .foregroundColor(.primary)
            }
          }
        }
      }
    }
    .edgesIgnoringSafeArea(.top)
    .environmentObject(exchangePresenter)
    .onAppear() {
      self.currencyManager.fetchBankCurrency()
      self.currencyManager.fetchPrivat24Currency()
    }
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
      .foregroundColor(Color("currencyIconColor"))
      .padding(25)
      .padding(.top, 40)
  }
}

//MARK: - Small Text View

struct SmallTextView: View {
  let text: String
  var body: some View {
    Text(text)
      .font(Font.custom("HelveticaNeue", size: 20))
      .foregroundColor(.white)
  }
}

//MARK: - Large Text View

struct LargeTextView: View {
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
