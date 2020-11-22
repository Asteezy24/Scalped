//
//  NewStrategyDataManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/18/20.
//

import Foundation
import Combine





class NewStrategyDataManager {
    func sendNewStrategyToServer(_ strategy: Strategy) {
        let url = String(format: "http://127.0.0.1:3000/strategy/")
        guard let serviceUrl = URL(string: url) else { return }
        let parameters: [String: String] = [
            "action" : strategy.action,
            "underlying": strategy.strategyUnderlying
        ]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        request.timeoutInterval = 3
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                //print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    //print(json)
                } catch {
                    //print(error)
                }
            }
        }.resume()
    }
}

