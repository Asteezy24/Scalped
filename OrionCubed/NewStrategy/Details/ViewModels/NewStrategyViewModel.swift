//
//  NewStrategyViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import SwiftUI
import Combine

class NewStrategyViewModel: ObservableObject {
    @Binding var strategyList: [Strategy]
    @Published var errorAlert: Bool = false
    
    private var disposables = Set<AnyCancellable>()
    private let dataManager = NewStrategyDataManager(networkManager: NetworkManager())
    
    init(strategyList: Binding<[Strategy]>) {
        self._strategyList = strategyList
    }
    
    func saveStrategy(_ strategy: Strategy) {
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
}
