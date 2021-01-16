//
//  AddWatchlistItemViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/9/21.
//

import Combine
import SwiftUI

class AddWatchlistItemViewModel: ObservableObject {
    @Published var searchResults = [String]()
    @Published var underlyingEntry = ""
    private var dataManager = WatchlistDataManager()
    private var disposables = Set<AnyCancellable>()
    
    init() {
        $underlyingEntry
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue(label: "AddWatchlistViewModel"))
            .sink(receiveValue: fetchEligibleUnderlyings(for:))
            .store(in: &disposables)
    }
    
    func addToWatchlist(name: String) {
        self.dataManager.getAddStockPublisher(name)
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
    
    func fetchEligibleUnderlyings(for entry: String) {
        self.dataManager.getSymbolsPublisher(entry)
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
                    self.searchResults = httpResponse.data
                } else {
                    print("got error " + httpResponse.message)
                }
            })
            .store(in: &disposables)
    }
    
}
