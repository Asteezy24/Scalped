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
    func getCreateStrategyPublisher(_ strategy: Strategy) -> AnyPublisher<NetworkResponse, Error>
}

class NewStrategyDataManager: StrategyDataManaging {
        
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getCreateStrategyPublisher(_ strategy: Strategy) -> AnyPublisher<NetworkResponse, Error> {

        let endpoint = Endpoint.createStrategy
        let parameters: [String: String] = [
            "action" : strategy.action,
            "identifier": "GMMA",
            "username": "alex"
        ]

        return self.networkManager.request(type: NetworkResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
    
    func getSymbolsPublisher(_ symbol: String) -> AnyPublisher<SymbolsNetworkResponse, Error> {
        let endpoint = Endpoint.getSymbols
        let parameters: [String: String] = [
            "symbol" : symbol
        ]
        return self.networkManager.request(type: SymbolsNetworkResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
}
