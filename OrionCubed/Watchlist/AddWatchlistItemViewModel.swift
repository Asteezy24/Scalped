//
//  AddWatchlistItemViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/9/21.
//

import Combine
import SwiftUI

class AddWatchlistItemViewModel: ObservableObject {
    private var dataManager = WatchlistDataManager()
    @Published var searchResults = [Symbol]()
    @Published var underlyingEntry = ""
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
            .map { response in
                if response.error {
                    print("got error\n\n\n")
                }
            }
            .sink(receiveCompletion: { [weak self] value in
                guard let _ = self else { return }
                switch value {
                case .failure:
                    break
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] response in
                guard let _ = self else { return }
            })
            .store(in: &disposables)
    }
    
    func fetchEligibleUnderlyings(for entry: String) {
        self.dataManager.getSymbolsPublisher(entry)
            .receive(on: DispatchQueue.main)
            .map { response in
                if !response.error {
                    for symbol in response.data {
                        self.searchResults.append(Symbol(name: symbol.name))
                    }
                } else {
                    print("got error\n\n\n")
                }
            }
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let _ = self else { return }
                    switch value {
                    case .failure:
                        break
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] data in
                    guard let _ = self else { return }
                    //self.searchResults = data
                })
            .store(in: &disposables)
    }
    
}
