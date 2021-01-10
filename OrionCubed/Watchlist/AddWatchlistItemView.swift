//
//  AddWatchlistItemView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/30/20.
//

import SwiftUI

struct AddWatchlistItemView: View {
    @State var stocksAdded = [String]()
    @ObservedObject var viewModel: AddWatchlistItemViewModel
    @State var searchResults: [String] = []
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Search for a stock", text: $viewModel.underlyingEntry)
                }
                List {
                    
                    ForEach(viewModel.searchResults, id: \.self) { symbol in
                        HStack {
                            Text(symbol.name)
                            Spacer()
                            Image(systemName: $stocksAdded.wrappedValue.contains(symbol.name)
                                    ? "checkmark"
                                    : "plus")
                            .onTapGesture {
                                stocksAdded.append(symbol.name)
                                viewModel.addToWatchlist(name: symbol.name)
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
        AddWatchlistItemView(viewModel: AddWatchlistItemViewModel())
    }
}
