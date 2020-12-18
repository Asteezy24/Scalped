//
//  NewStrategyViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import SwiftUI
import Combine

struct Symbol: Identifiable {
    var id = UUID()
    var name: String
}

class NewStrategyViewModel: ObservableObject {
    @Binding var strategyList: [Strategy]
    @Published var strategyName: String
    @Published var searchResults = [Symbol]()
    @Published var selectedUnderlying = false
    @Published var underlyingEntry = ""
    @Published var errorAlert: Bool = false
    @Published var actionSelected = 0
    
    let strategyActions = ["Buy", "Sell"]
    
    private var disposables = Set<AnyCancellable>()
    private let dataManager = NewStrategyDataManager(networkManager: NetworkManager())
    
    init(strategyName: String, strategyList: Binding<[Strategy]>) {
        self.strategyName = strategyName
        self._strategyList = strategyList
        $underlyingEntry
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue(label: "WeatherViewModel"))
            .sink(receiveValue: fetchEligibleUnderlyings(for:))
            .store(in: &disposables)
    }
    
    func saveStrategy() {
        let strategy = Strategy(identifier: strategyName,
                                underlying: underlyingEntry,
                                action: strategyActions[actionSelected])
        self.dataManager.getCreateStrategyPublisher(strategy)
            .receive(on: DispatchQueue.main)
            .map { response in
                print(response)
                if !response.error {
                    self.strategyList.append(strategy)
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
                        self?.errorAlert = true
                        print("")
                    case .finished:
                        print("")
                    }
                },
                receiveValue: { [weak self] response in
                    guard let _ = self else { return }
                    //print(response)
                })
            .store(in: &disposables)
    }
    
    func fetchEligibleUnderlyings(for entry: String) {
        guard !self.selectedUnderlying else { return }
        self.dataManager.getSymbolsPublisher(entry)
            .receive(on: DispatchQueue.main)
            .map { response in
                if !response.error {
                    for symbol in response.data {
                        self.searchResults.append(Symbol(name: symbol))
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
}
