//
//  CreateAccountDataManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/28/21.
//

import Combine

class CreateAccountDataManager {
        
    let networkManager = NetworkManager()
    
    func getCreateNewUserPublisher(_ user: NewUser) -> AnyPublisher<NetworkResponse, Error> {
        let endpoint = Endpoint.createUser
        let parameters: [String: String] = [
            "username": user.username,
            "password": user.password
        ]

        return self.networkManager.request(type: NetworkResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
}
