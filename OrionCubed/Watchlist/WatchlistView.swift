//
//  WatchlistView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/29/20.
//

import SwiftUI

struct WatchlistView: View {
    
    @ObservedObject var viewModel: WatchlistViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    List(0..<viewModel.watchlist.count, id: \.self) { row in
                        WatchlistItem(stock: viewModel.watchlist[row])
                    }
                    .listStyle(InsetGroupedListStyle())
                    Spacer()
                }
            }.onAppear(perform: {
                self.viewModel.getWatchlist()
            })
            .navigationBarTitle("Watchlist")
            .navigationBarItems(trailing: NavigationLink(destination: AddWatchlistItemView(viewModel: AddWatchlistItemViewModel())) {
                Image(systemName:"plus").imageScale(.large)
            })
        }
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WatchlistView(viewModel: WatchlistViewModel())
        }
    }
}
