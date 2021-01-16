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
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Search for a stock", text: $viewModel.underlyingEntry)
                }
                List {
                    ForEach(viewModel.searchResults, id: \.self) { symbol in
                        HStack {
                            Text(symbol)
                            Spacer()
                            Image(systemName: $stocksAdded.wrappedValue.contains(symbol)
                                    ? "checkmark"
                                    : "plus")
                                .onTapGesture {
                                    stocksAdded.append(symbol)
                                    viewModel.addToWatchlist(name: symbol)
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
