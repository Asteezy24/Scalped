//
//  NewStrategyViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import SwiftUI
import Combine

class NewStrategyViewModel: ObservableObject {
    @Published var strategyList: [Strategy]
    private var disposables = Set<AnyCancellable>()
    var dataManager = NewStrategyDataManager(networkManager: NetworkManager())
    
    init(strategyList: [Strategy]) {
        self.strategyList = strategyList
    }
    
    func saveStrategy(_ strategy: Strategy) {
        self.strategyList.append(strategy)
        self.dataManager.createStrategy(strategy)
//            .sink { (error) in
//                print(error)
//            } receiveValue: { (response) in
//                print(response)
//            }
//            .store(in: &disposables)
        
    }
}
