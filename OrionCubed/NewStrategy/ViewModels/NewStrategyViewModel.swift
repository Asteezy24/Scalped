//
//  NewStrategyViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import SwiftUI
import Combine

class NewStrategyViewModel {
    @Binding var strategyList: [Strategy]
    
    private var disposables = Set<AnyCancellable>()
    private let dataManager = NewStrategyDataManager(networkManager: NetworkManager())
    
    init(strategyList: Binding<[Strategy]>) {
        self._strategyList = strategyList
    }
    
    
    func saveStrategy(_ strategy: Strategy) {
        self.dataManager.createStrategy(strategy)
            .map { response in
                if !response.error {
                    self.strategyList.append(strategy)
                }
                print(response)
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        print(value)
                    case .finished:
                        print(value)
                        break
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    print(response)
                })
            .store(in: &disposables)
        
    }
}
