//
//  NewStrategyDataManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/18/20.
//

import Foundation
import Combine

class NewStrategyDataManager: StrategyDataManaging {
        
    let networkManager: NetworkManagerProtocol
    var disposables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func createStrategy(_ strategy: Strategy) -> AnyPublisher<NetworkResponse, Error> {
        let endpoint = Endpoint.createStrategy
        
        let parameters: [String: String] = [
            "action" : "foo",
            "underlying": "bar"
        ]
        let url = String(format: "http://127.0.0.1:3000/strategy/")

        let serviceUrl = URL(string: url)!
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = httpBody
        request.timeoutInterval = 3
        
        return  URLSession.shared.dataTaskPublisher(for: request)
            .map {value in
                let responseData = String(data: value.data, encoding: .utf8)!
//                print("\n")
//                print(responseData)
//                print("\n")
                return Data.init(value.data)
            }
            .decode(type: NetworkResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
