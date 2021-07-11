//
//  WatchlistViewModel.swift
//  Scalped
//
//  Created by Alexander Stevens on 1/9/21.
//

import Combine
import SwiftUI

class WatchlistViewModel: ObservableObject {
    @Published var watchlist = [WatchlistStockItem]()
    private var dataManager = WatchlistDataManager()
    private var disposables = Set<AnyCancellable>()
    
    func getWatchlist() {
        self.dataManager.getPublisherForWatchlist()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                default: break
                }
            }, receiveValue: { httpResponse in
                print(httpResponse)
                if !httpResponse.error {
                    self.watchlist = httpResponse.data
                } else {
                    print("got error " + httpResponse.message)
                }
            })
            .store(in: &disposables)
    }
    
    func deleteFromWatchlist(name: String) {
        self.dataManager.getDeleteStockPublisher(name)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                default: break
                }
            }, receiveValue: { httpResponse in
                print(httpResponse)
                if httpResponse.error {
                    print("got error " + httpResponse.message)
                }
            })
            .store(in: &disposables)
    }
}
