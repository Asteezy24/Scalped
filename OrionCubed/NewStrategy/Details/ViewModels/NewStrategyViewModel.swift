//
//  NewStrategyViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import SwiftUI
import Combine

struct Symbol: Hashable, Decodable {
    var name: String
}

class NewStrategyViewModel: ObservableObject {
    
    // Common/Shared
    @Published var strategyName: String
    @Published var searchResults = [Symbol]()
    @Published var selectedUnderlying = false
    @Published var underlyingEntry = ""
    @Published var errorAlert: Bool = false
    // Moving Average
    @Published var actionSelected = 0
    @Published var timeframeSelected = 0
    // Yield
    @Published var yieldBuyGoal: Double = 6
    @Published var yieldSellGoal: Double = 6
    @Published var underlyingOptionSelected = 0
    
    let strategyActions = ["Buy", "Sell"]
    let timeframes = ["1H", "1D"]
    let yieldUnderlyingOptions = ["Use my watchlist", "Specific Stock"]
    
    
    private var disposables = Set<AnyCancellable>()
    private let dataManager = NewStrategyDataManager(networkManager: NetworkManager())
    
    init(strategyName: String) {
        self.strategyName = strategyName
        $underlyingEntry
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue(label: "StrategyViewModel"))
            .sink(receiveValue: fetchEligibleUnderlyings(for:))
            .store(in: &disposables)
    }
    
    func saveMovingAverageStrategy() {
        let strategy = MovingAverageStrategy(identifier: strategyName,
                                             underlying: underlyingEntry,
                                             action: strategyActions[actionSelected],
                                             timeframe: timeframes[timeframeSelected])
        self.dataManager.getCreateMAStrategyPublisher(strategy)
            .receive(on: DispatchQueue.main)
            .map { response in
                if response.error {
                    print("got error\n\n\n")
                    DispatchQueue.main.async {
                        self.errorAlert = true
                    }
                }
            }
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let _ = self else { return }
                    switch value {
                    case .failure:
                        self?.errorAlert = true
                        break
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] response in
                    guard let _ = self else { return }
                })
            .store(in: &disposables)
        //reset values
        self.selectedUnderlying = false
        self.underlyingEntry = ""
        self.searchResults = []
    }
    
    func saveYieldStrategy() {
        var stocks = [String]()
        if self.underlyingOptionSelected == 0 {
            self.dataManager.getPublisherForWatchlist()
                .receive(on: DispatchQueue.main)
                .map { data in
                    for item in data.data {
                        stocks.append(item.name)
                    }
                    self.sendYieldToServer(stocks: stocks)
                }.sink(receiveCompletion: { [weak self] value in
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
            
        } else {
            stocks = [underlyingEntry]
        }
        
    }
    
    func fetchEligibleUnderlyings(for entry: String) {
        guard !self.selectedUnderlying else { return }
        self.dataManager.getSymbolsPublisher(entry)
            .receive(on: DispatchQueue.main)
            .map { response in
                if !response.error {
                    for symbol in response.data {
                        self.searchResults.append(Symbol(name: symbol.name))
                    }
                } else {
                    print("got error\n\n\n")
                    DispatchQueue.main.async {
                        self.errorAlert = true
                    }
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
    
    
    func sendYieldToServer(stocks: [String]) {
        let strategy = YieldStrategy(identifier: strategyName, stocks: stocks, yieldBuyGoal: String(self.yieldBuyGoal), yieldSellGoal: String(self.yieldSellGoal))
        self.dataManager.getCreateYieldStrategyPublisher(strategy)
            .receive(on: DispatchQueue.main)
            .map { response in
                if response.error {
                    print("got error\n\n\n")
                    DispatchQueue.main.async {
                        self.errorAlert = true
                    }
                }
            }
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let _ = self else { return }
                    switch value {
                    case .failure:
                        self?.errorAlert = true
                        break
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] response in
                    guard let _ = self else { return }
                })
            .store(in: &disposables)
        //reset values
        self.selectedUnderlying = false
        self.underlyingEntry = ""
        self.searchResults = []
    }
}
