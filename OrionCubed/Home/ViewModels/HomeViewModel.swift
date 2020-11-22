//
//  HomeViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import Foundation
import Combine

var stocks = ["AAPL", "SPY", "GLD", "NIO", "TSLA", "EBAY", "IBM"]
var actions = ["Buy", "Sell"]

class HomeViewModel: ObservableObject {
    @Published var alerts = [Alert]()
    @Published var strategies = [Strategy]()
    private var dataManager = HomeAlertDataManager()
    
    init() {
        self.dataManager.listenForUpdates(completion: {[weak self] alert in
            self?.handleAlert(alert)
        })
    }
    
    private func handleAlert(_ alert: Alert) {
        DispatchQueue.main.async {
            self.alerts.append(alert)
        }
    }
}
