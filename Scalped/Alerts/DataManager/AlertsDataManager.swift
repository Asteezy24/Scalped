//
//  AlertsDataManager.swift
//  Scalped
//
//  Created by Alexander Stevens on 1/4/21.
//

import Combine
import SwiftUI

class AlertsDataManager {
    public private(set) var networkManager = NetworkManager()
    
    func getPublisherForAlerts() -> AnyPublisher<AlertResponse, Error> {
        let endpoint = Endpoint.getAlerts
        let parameters: [String: String] = ["username": UserDefaults.standard.string(forKey: "CurrentUsername") ?? ""]

        return self.networkManager.request(type: AlertResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
    
    func getPublisherForBuySignal(alert: StrategyAlert) -> AnyPublisher<NetworkResponse, Error> {
        let endpoint = Endpoint.addToPortfolio
        let parameters: [String: String] = [
            "username": UserDefaults.standard.string(forKey: "CurrentUsername") ?? "",
            "typeOfAlert": alert.typeOfAlert,
            "underlying": alert.underlying
        ]
        
        return self.networkManager.request(type: NetworkResponse.self, requestType: .post, parameters: parameters, url: endpoint.url, headers: [:])
    }
    
}
