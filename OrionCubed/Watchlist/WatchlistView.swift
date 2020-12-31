//
//  WatchlistView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/29/20.
//

import SwiftUI

struct WatchlistView: View {
    
    @State var stocks = [
        Stock(name: "AAPL", price: "$400.98"),
        Stock(name: "TSLA", price: "$250.00")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    List(0..<stocks.count, id: \.self) { row in
                        WatchlistItem(stock: stocks[row])
                    }
                    .listStyle(InsetGroupedListStyle())
                    Spacer()
                }
            }
            .navigationBarTitle("Watchlist")
            .navigationBarItems(trailing: NavigationLink(destination: AddWatchlistItemView(watchlist: $stocks)) {
                Image(systemName:"plus").imageScale(.large)
            })
        }
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WatchlistView()
        }
    }
}
