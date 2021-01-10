//
//  WatchlistDataManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/9/21.
//

import Combine
import SwiftUI

class WatchlistDataManager {
    private var urlSession: URLSession = .shared
    public private(set) var networkManager = NetworkManager()
    
    func getPublisherForWatchlist() -> AnyPublisher<WatchlistResponse, Error> {
        let endpoint = Endpoint.getWatchlist
        let parameters: [String: String] = ["username": "alex"]

        return self.networkManager.request(type: WatchlistResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }

    func getAddStockPublisher(_ name: String) -> AnyPublisher<NetworkResponse, Error> {
        let endpoint = Endpoint.addToWatchlist
        let parameters: [String: String] = [
            "stock": name,
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
