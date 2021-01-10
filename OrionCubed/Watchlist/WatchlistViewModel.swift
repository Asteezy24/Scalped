//
//  WatchlistViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/9/21.
//

import Combine
import SwiftUI

class WatchlistViewModel: ObservableObject {
    private var dataManager = WatchlistDataManager()
    private var disposables = Set<AnyCancellable>()
    @Published var watchlist = [Stock]()
    
    func getWatchlist() {
        self.dataManager.getPublisherForWatchlist()
            .receive(on: DispatchQueue.main)
            .map { response in
                if !response.error {
                    self.watchlist = response.data
                } else {
                    print("got error\n\n\n")
                }
            }
            .sink(receiveCompletion: { [weak self] value in
                guard let _ = self else { return }
                switch value {
                case .failure:
                    print(value)
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] response in
                guard let _ = self else { return }
            })
            .store(in: &disposables)
    }
    
    func addToWatchlist(name: String) {
        self.dataManager.getAddStockPublisher(name)
            .receive(on: DispatchQueue.main)
            .map { response in
                    print(response)
                if !response.error {
                    print("added!")
                    //self.watchlist = response.data
                } else {
                    print("got error\n\n\n")
                }
            }
            .sink(receiveCompletion: { [weak self] value in
                guard let _ = self else { return }
                switch value {
                case .failure:
                    print(value)
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] response in
                guard let _ = self else { return }
            })
            .store(in: &disposables)
    }
    
}
