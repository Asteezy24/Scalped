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
    @Published var portfolio = [PortfolioItem]()
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
    
    func getPortfolio() {
        self.dataManager.getPortfolioPublisher()
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
                    self.portfolio = httpResponse.data
                } else {
                    print("got error " + httpResponse.message)
                }
            })
            .store(in: &disposables)
    }
    
    func sendDeviceTokenToServer() {
        guard let tokenFromDefaults = UserDefaults.standard.string(forKey: "CurrentDeviceToken"),
              let deviceToken = Data(base64Encoded: tokenFromDefaults) else { return }
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        let endpoint = Endpoint.sendDeviceId
        let parameterDictionary = [
            "username": UserDefaults.standard.string(forKey: "CurrentUsername") ?? "",
            "deviceToken" : token
        ]
        
        NetworkManager().request(type: NetworkResponse.self, requestType: .post, parameters: parameterDictionary, url: endpoint.url, headers: [:])
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                default: break
                }
            }, receiveValue: { httpResponse in
                print(httpResponse)
                if httpResponse.error {
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
        calendar.timeZone = TimeZone(identifier: TimeZone.current.abbreviation() ?? "") ?? .current
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
