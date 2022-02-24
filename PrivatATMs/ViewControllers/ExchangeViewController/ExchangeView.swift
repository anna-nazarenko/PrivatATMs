//
//  ExchangeView.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 21.02.2022.
//

import SwiftUI

struct ExchangeView: View {
  let currency = ["USD", "EUR", "RUR", "BTC"]
  @State private var selectedBankCurrency = "USD"
  @State private var selectedPrivat24Currency = "USD"
  var buyRate = "28,16"
  var saleRate = "28,31"
  private var results = [Currency]()
  
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
              
              Text(buyRate)
                .font(Font.system(size: 55))
                .fontWeight(.regular)
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 1)
            }
            
            VStack {
              Text("Sale")
                .font(Font.custom("HelveticaNeue", size: 25))
                .foregroundColor(.white)
              Text(saleRate)
                .font(Font.system(size: 55))
                .fontWeight(.regular)
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 1)
            }
          }
        }
      }
      
      ZStack {
        Color(UIColor(.yellow))
        
        VStack {
          Text("Bank")
            .font(Font.custom("HelveticaNeue", size: 20))
          
          Picker("Choose a currency:", selection: $selectedBankCurrency) {
            ForEach(currency, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.segmented)
          .padding(15)
          
          Text("Privat24")
            .font(Font.custom("HelveticaNeue", size: 20))
            .padding(.top, 45)
          
          Picker("Choose a currency:", selection: $selectedPrivat24Currency) {
            ForEach(currency, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.segmented)
          .padding(15)
        }
      }
    }
    .edgesIgnoringSafeArea(.top)
  }
}

struct ExchangeView_Previews: PreviewProvider {
  static var previews: some View {
    ExchangeView()
  }
}
