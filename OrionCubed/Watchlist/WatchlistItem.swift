//
//  WatchlistItem.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/30/20.
//

import SwiftUI

struct WatchlistItem: View {
    
    let stock: Stock
    
    var body: some View {
        VStack {
            HStack {
                Text(stock.name)
                    .font(.headline)
                Spacer()
                VStack {
                    Text(stock.price)
                        .font(.headline)
                }
            }
            HStack {
                Text("Price Added to watchlist: ")
                    .font(.caption)
                Spacer()
                VStack {
                    Text("$1.00")
                        .font(.caption)
                }
            }
        }
    }
}

struct WatchlistItem_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistItem(stock: Stock(name: "$TSLA", price: "620.89"))
    }
}
