//
//  AddWatchlistItemView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/30/20.
//

import SwiftUI

var stocks = ["EBAY", "AAPL", "TSLA", "GME", "LIVX", "OZ"]

struct AddWatchlistItemView: View {
    
    @State var searchEntry: String = ""
    @Binding var watchlist: [Stock]
    @State var searchResults: [String] = []
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Search for a stock", text: $searchEntry)
                }
                List {
                    
                    ForEach(stocks.filter { stock in
                        return stock.uppercased().contains($searchEntry.wrappedValue.uppercased())
                    }, id: \.self) { name in
                        HStack {
                            Text(name)
                            Spacer()
                            Image(systemName: watchlist.contains(where: { stock in
                                name == stock.name
                            }) ? "checkmark": "plus")
                            .onTapGesture {
                                $watchlist.wrappedValue.append(Stock(name: name, price: "$1.00"))
                                
                            }
                        }
                    }
                    
                }
            }
            .navigationBarTitle("Add", displayMode: .inline)
        }
    }
    
}

struct AddWatchlistItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddWatchlistItemView(watchlist: .constant([Stock(name: "AAPL", price: "$1.00")]))
    }
}
