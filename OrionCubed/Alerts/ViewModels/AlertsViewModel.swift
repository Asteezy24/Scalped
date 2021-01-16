//
//  AlertsViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/4/21.
//

import Combine
import SwiftUI

class AlertsViewModel: ObservableObject {
    
    @Published var alerts = [StrategyAlert]()
    private var dataManager = AlertsDataManager()
    private var disposables = Set<AnyCancellable>()
    
    func getAllAlerts() {
        self.dataManager.getPublisherForAlerts()
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
                    self.alerts = httpResponse.data
                } else {
                    print("got error " + httpResponse.message)
                }
            })
            .store(in: &disposables)
    }
}
