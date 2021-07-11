//
//  SignInDataManager.swift
//  Scalped
//
//  Created by Alexander Stevens on 1/29/21.
//

import Combine

class SignInDataManager {
        
    let networkManager = NetworkManager()
    
    func getSignInPublisher(username: String, password: String) -> AnyPublisher<NetworkResponse, Error> {
        let endpoint = Endpoint.signIn
        let parameters: [String: String] = [
            "username": username,
            "password": password
        ]

        return self.networkManager.request(type: NetworkResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
}
