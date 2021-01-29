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
    
    func determineBannerGreeting() -> String {
        let date = Date()
        // *** create calendar object ***
        var calendar = Calendar.current
        // *** define calendar components to use as well Timezone to UTC ***
        calendar.timeZone = TimeZone(identifier: TimeZone.current.abbreviation() ?? "")!
        // *** Get Individual components from date ***
        let hour = calendar.component(.hour, from: date)
        if (6 <= hour && hour <= 12) {
            return "Good Morning!"
        } else if (13 <= hour && hour <= 17) {
            return "Good Afternoon!"
        } else {
            return "Good Evening!"
        }
    }
}
