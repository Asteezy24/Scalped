//
//  WatchlistView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/29/20.
//

import SwiftUI

var stocks = ["AAPL", "SPY", "GLD", "NIO", "TSLA", "EBAY", "IBM"]
var prices = ["$242.50", "$365.72", "$176.35", "$46.72", "$626.78", "$100.00", "$100.00"]
var percentChange = ["+1.4%", "-3.7%", "+9.8%", "+10%", "-7%", "+14%", "0%"]

struct WatchlistView: View {
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Watchlist")
                            .font(.system(size: 34, weight: .heavy))
                        Spacer()
                    }
                    .padding()
                }
                List(0..<stocks.count) { row in
                    HStack {
                        Text(stocks[row])
                            .font(.headline)
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 5) {
                            Text(prices[row])
                                .font(.headline)
                            Text(percentChange[row])
                                .font(.caption)
                        }
                    }
                    
                }
                .listStyle(InsetGroupedListStyle())
            }
            Button(action: {print("")}) {
                Text("Add New")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .offset(x: 0, y: 250)
                    .foregroundColor(Color.white)
            }
            .padding()
        }
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
    }
}
