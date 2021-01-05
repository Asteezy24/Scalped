//
//  AlertsViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/4/21.
//

import Combine
import SwiftUI

class AlertsViewModel: ObservableObject {
    
    private var dataManager = AlertsDataManager()
    @Published var alerts = [StrategyAlert]()
    private var disposables = Set<AnyCancellable>()
    
    
    init() {
        //socket
//        self.dataManager.listenForUpdates(completion: {[weak self] alert in
//            self?.handleAlert(alert)
//        })
    }
    
    
    private func handleAlert(_ alert: StrategyAlert) {
        DispatchQueue.main.async {
            self.alerts.append(alert)
        }
    }

    func getAllAlerts() {
        self.dataManager.getPublisherForAlerts()
            .receive(on: DispatchQueue.main)
            .map { response in
                //print(response)
                if !response.error {
                    self.alerts = response.data
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
