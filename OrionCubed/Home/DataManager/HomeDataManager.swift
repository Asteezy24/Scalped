//
//  HomeAlertDataManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/17/20.
//

import Foundation
import Combine
import SwiftUI

class HomeDataManager: NSObject, ObservableObject {
    private lazy var websocketURL = "ws://" + ( currEnvironment == environments.dev ? environments.prod.rawValue : environments.prod.rawValue) + ":1337"
    private var urlSession: URLSession?
    public private(set) var networkManager = NetworkManager()
}

// get data from server
extension HomeDataManager {
    
    func getPublisherForAlerts() -> AnyPublisher<AlertResponse, Error> {
        let endpoint = Endpoint.getAlerts
        let parameters: [String: String] = ["username": "alex"]

        return self.networkManager.request(type: AlertResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
    
    func getPublisherForStrategies() -> AnyPublisher<StrategyResponse, Error> {
        let endpoint = Endpoint.getStrategies
        let parameters: [String: String] = ["username": "alex"]

        return self.networkManager.request(type: StrategyResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
    
}
