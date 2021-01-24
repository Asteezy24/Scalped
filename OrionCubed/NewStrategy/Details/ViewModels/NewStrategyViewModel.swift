//
//  NewStrategyViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import SwiftUI
import Combine

class NewStrategyViewModel: ObservableObject {
    // Common/Shared
    @Published var strategyName: String
    @Published var searchResults = [String]()
    @Published var selectedUnderlying = false
    @Published var underlyingEntry = ""
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
    private let dataManager = NewStrategyDataManager()
    
    init(strategyName: String) {
        self.strategyName = strategyName
        $underlyingEntry
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue(label: "StrategyViewModel"))
            .sink(receiveValue: fetchEligibleUnderlyings(for:))
            .store(in: &disposables)
    }
    
    func fetchEligibleUnderlyings(for entry: String) {
        guard entry != "" else { return }
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
    
    private func resetValues() {
        self.selectedUnderlying = false
        self.underlyingEntry = ""
        self.searchResults = []
    }
    
}

// Moving Average
extension NewStrategyViewModel {
    func saveMovingAverageStrategy() {
        let strategy = MovingAverageStrategy(identifier: strategyName,
                                             underlyings: [underlyingEntry],
                                             action: strategyActions[actionSelected],
                                             timeframe: timeframes[timeframeSelected])
        self.dataManager.getCreateMAStrategyPublisher(strategy)
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
        resetValues()
    }
}

// Yield
extension NewStrategyViewModel {
    func saveYieldStrategy() {
        if self.underlyingOptionSelected == 0 {
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
                        self.sendYieldToServer(stocks: httpResponse.data.map{$0.name})
                    } else {
                        print("got error " + httpResponse.message)
                    }
                })
                .store(in: &disposables)
            
        } else {
            self.sendYieldToServer(stocks: [self.underlyingEntry])
            
        }
        
    }
    
    func sendYieldToServer(stocks: [String]) {
        let strategy = YieldStrategy(identifier: strategyName,
                                     underlyings: stocks,
                                     yieldBuyGoal: String(self.yieldBuyGoal),
                                     yieldSellGoal: String(self.yieldSellGoal),
                                     isFullWatchlist: self.underlyingOptionSelected == 0)
        self.dataManager.getCreateYieldStrategyPublisher(strategy)
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
        //reset values
        resetValues()
    }
}
