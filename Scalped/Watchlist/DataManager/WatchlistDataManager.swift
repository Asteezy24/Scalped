//
//  WatchlistDataManager.swift
//  Scalped
//
//  Created by Alexander Stevens on 1/9/21.
//

import Combine
import SwiftUI

class WatchlistDataManager {
    public private(set) var networkManager = NetworkManager()
    
    func getPublisherForWatchlist() -> AnyPublisher<WatchlistResponse, Error> {
        let endpoint = Endpoint.getWatchlist
        let parameters: [String: String] = ["username": UserDefaults.standard.string(forKey: "CurrentUsername") ?? ""]

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
            "username": UserDefaults.standard.string(forKey: "CurrentUsername") ?? ""
        ]

        return self.networkManager.request(type: NetworkResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
    func getDeleteStockPublisher(_ name: String) -> AnyPublisher<NetworkResponse, Error> {
        let endpoint = Endpoint.deleteFromWatchlist
        let parameters: [String: String] = [
            "stock": name,
            "username": UserDefaults.standard.string(forKey: "CurrentUsername") ?? ""
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
