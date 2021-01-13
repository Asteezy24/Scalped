//
//  NewStrategyDataManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/18/20.
//

import Foundation
import Combine

class NewStrategyDataManager {
        
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getCreateMAStrategyPublisher(_ strategy: MovingAverageStrategy) -> AnyPublisher<NetworkResponse, Error> {
        let endpoint = Endpoint.createStrategy
        let parameters: [String: String] = [
            "underlying": strategy.underlying,
            "action" : strategy.action,
            "identifier": strategy.identifier,
            "timeframe": strategy.timeframe,
            "username": "alex"
        ]

        return self.networkManager.request(type: NetworkResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
    
    func getCreateYieldStrategyPublisher(_ strategy: YieldStrategy) -> AnyPublisher<NetworkResponse, Error> {
        let endpoint = Endpoint.createStrategy
        let parameters: [String: Any] = [
            "identifier": strategy.identifier,
            "yieldUnderlyings": strategy.stocks,
            "yieldBuyPercent": strategy.yieldBuyGoal,
            "yieldSellPercent": strategy.yieldSellGoal,
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
    
    func getPublisherForWatchlist() -> AnyPublisher<WatchlistResponse, Error> {
        let endpoint = Endpoint.getWatchlist
        let parameters: [String: String] = ["username": "alex"]

        return self.networkManager.request(type: WatchlistResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
}
