//
//  HomeViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var strategies = [BaseStrategy]()
    private var dataManager = HomeDataManager()
    private var disposables = Set<AnyCancellable>()
    
    func getAllStrategies() {
        self.dataManager.getPublisherForStrategies()
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
                    self.strategies = httpResponse.data
                } else {
                    print("got error " + httpResponse.message)
                }
            })
            .store(in: &disposables)
    }
    
}
