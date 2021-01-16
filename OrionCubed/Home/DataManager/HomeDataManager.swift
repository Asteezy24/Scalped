//
//  HomeAlertDataManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/17/20.
//

import Combine

class HomeDataManager {
    public private(set) var networkManager = NetworkManager()
    
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
