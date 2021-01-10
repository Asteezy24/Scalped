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
                    List {
                        ForEach(0..<viewModel.watchlist.count, id: \.self) { row in
                            WatchlistItem(item: viewModel.watchlist[row])
                        }.onDelete(perform: delete)
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
    
    func delete(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        self.viewModel.deleteFromWatchlist(name: self.viewModel.watchlist[index].name)
        self.viewModel.watchlist.remove(at: index)
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WatchlistView(viewModel: WatchlistViewModel())
        }
    }
}
