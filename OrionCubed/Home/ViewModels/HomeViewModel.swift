//
//  HomeViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import Foundation
import Combine
import SwiftUI

var stocks = ["AAPL", "SPY", "GLD", "NIO", "TSLA", "EBAY", "IBM"]
var actions = ["Buy", "Sell"]

class HomeViewModel: ObservableObject {
    @Published var alerts = [StrategyAlert]()
    @Published var strategies = [Strategy]()
    @Published var connectedToServer = false
    private var dataManager: HomeDataManager?
    private var disposables = Set<AnyCancellable>()
    
    init() {
        self.dataManager = HomeDataManager()
        self.dataManager?.listenForUpdates(completion: {[weak self] alert in
            self?.handleAlert(alert)
        })
        self.dataManager?.$connectedToServer.sink(receiveValue: { isConnected in
            DispatchQueue.main.async {
                self.connectedToServer = isConnected
            }
        })
        .store(in: &disposables)
    }
    
    private func handleAlert(_ alert: StrategyAlert) {
        DispatchQueue.main.async {
            self.alerts.append(alert)
        }
    }
}
