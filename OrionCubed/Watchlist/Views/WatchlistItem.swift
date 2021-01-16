//
//  WatchlistItem.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/30/20.
//

import SwiftUI

struct WatchlistItem: View {
    
    let item: WatchlistStockItem
    
    var body: some View {
        VStack {
            HStack {
                Text(item.name)
                    .font(.headline)
                Spacer()
                VStack {
                    Text(item.price)
                        .font(.headline)
                }
            }
            HStack {
                Text("Price Added to watchlist: ")
                    .font(.caption)
                Spacer()
                VStack {
                    Text(item.priceWhenAdded)
                        .font(.caption)
                }
            }
        }
    }
}

struct WatchlistItem_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistItem(item: WatchlistStockItem(name: "", price: "", priceWhenAdded: ""))
    }
}
