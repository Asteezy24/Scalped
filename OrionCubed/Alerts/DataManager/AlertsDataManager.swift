//
//  AlertsDataManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/4/21.
//

import Combine
import SwiftUI

class AlertsDataManager {
    public private(set) var networkManager = NetworkManager()
    
    func getPublisherForAlerts() -> AnyPublisher<AlertResponse, Error> {
        let endpoint = Endpoint.getAlerts
        let parameters: [String: String] = ["username": "alex"]

        return self.networkManager.request(type: AlertResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
    
}
