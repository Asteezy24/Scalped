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
    @Published var alerts = [Alert]()
    @Published var strategies = [Strategy]()
    var disposables = Set<AnyCancellable>()
    @Published var connectedToServer = false
    private var dataManager: HomeAlertDataManager?
    
    init() {
        self.dataManager = HomeAlertDataManager()
        self.dataManager?.listenForUpdates(completion: {[weak self] alert in
            self?.handleAlert(alert)
        })
        self.dataManager?.$connectedToServer.sink(receiveValue: { isConnected in
            self.connectedToServer = isConnected
        })
            .store(in: &disposables)
    }
    
    private func handleAlert(_ alert: Alert) {
        DispatchQueue.main.async {
            self.alerts.append(alert)
        }
    }
}
