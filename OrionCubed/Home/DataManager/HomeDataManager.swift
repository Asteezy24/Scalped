//
//  HomeAlertDataManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/17/20.
//

import Combine
import SwiftUI

class HomeDataManager {
    public private(set) var networkManager = NetworkManager()
    
    func getPublisherForStrategies() -> AnyPublisher<StrategyResponse, Error> {
        let endpoint = Endpoint.getStrategies
        let parameters: [String: String] = ["username": UserDefaults.standard.string(forKey: "CurrentUsername") ?? ""]
        
        return self.networkManager.request(type: StrategyResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
    
    func getPortfolioPublisher() -> AnyPublisher<PortfolioResponse, Error> {
        let endpoint = Endpoint.getPortfolio
        let parameters: [String: String] = [
            "username": UserDefaults.standard.string(forKey: "CurrentUsername") ?? ""
        ]
        
        return self.networkManager.request(type: PortfolioResponse.self, requestType: .post, parameters: parameters, url: endpoint.url, headers: [:])
    }
    
}
