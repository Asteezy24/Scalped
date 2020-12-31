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
        HStack {
            Text(stock.name)
                .font(.headline)
            Spacer()
            VStack {
                Text(stock.price)
                    .font(.headline)
            }
        }
    }
}

struct WatchlistItem_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistItem(stock: Stock(name: "$TSLA", price: "620.89"))
    }
}
