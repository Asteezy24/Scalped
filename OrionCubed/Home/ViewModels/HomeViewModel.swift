//
//  HomeViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import Foundation
import Combine
import SwiftUI

var actions = ["Buy", "Sell"]

class HomeViewModel: ObservableObject {
    @Published var strategies = [Strategy]()
    @Published var connectedToServer = false
    private var dataManager: HomeDataManager?
    private var disposables = Set<AnyCancellable>()
    
    init() {
        self.dataManager = HomeDataManager()
        self.dataManager?.$connectedToServer.sink(receiveValue: { isConnected in
            DispatchQueue.main.async {
                self.connectedToServer = isConnected
            }
        })
        .store(in: &disposables)
    }
    
    func getAllStrategies() {
        self.dataManager?.getPublisherForStrategies()
            .receive(on: DispatchQueue.main)
            .map { response in
                if !response.error {
                    self.strategies = response.data
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
