//
//  NewStrategyDataManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/18/20.
//

import Foundation
import Combine

protocol StrategyDataManaging: class {
    var networkManager: NetworkManagerProtocol { get }
    func createStrategy(_ strategy: Strategy) -> AnyPublisher<NetworkResponse, Error>
}

class NewStrategyDataManager: StrategyDataManaging {
        
    let networkManager: NetworkManagerProtocol
    var disposables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func createStrategy(_ strategy: Strategy) -> AnyPublisher<NetworkResponse, Error> {

        let endpoint = Endpoint.createStrategy
        let parameters: [String: String] = [
            "action" : strategy.action,
            "identifier": "",
            "username": "alex"
        ]

        return self.networkManager.request(type: NetworkResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
}

