//
//  HomeAlertDataManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/17/20.
//

import Foundation
import Combine

class HomeAlertDataManager {
    
    private var websocketURL = "ws://127.0.0.1:1337"
    private var urlSession: URLSession
    public private(set) var webSocketTask: URLSessionWebSocketTask
    
    init() {
        self.urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with: URL(string: websocketURL)!, protocols: ["echo-protocol"])
        webSocketTask.resume()
    }
    
    func sendMessage(_ message: String) {
        let message = URLSessionWebSocketTask.Message.string(message)
        webSocketTask.send(message) { error in
            if let error = error {
                print("WebSocket couldn’t send message because: \(error)")
            }
        }
    }
    
    func listenForUpdates(completion: @escaping (Alert) -> Void) {
        webSocketTask.receive {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    let alert = strongSelf.getAlert(from: text)
                    completion(alert)
                default: break
                }
                strongSelf.listenForUpdates(completion: completion)
            }
        }
    }
    
    func sendPing() {
        webSocketTask.sendPing { (error) in
            if let error = error {
                print("Sending PING failed: \(error)")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.sendPing()
            }
        }
    }
    
    func closeConnection() {
        webSocketTask.cancel(with: .goingAway, reason: nil)
    }
    
    func getAlert(from text: String) -> Alert {
        print("Received: \(text)")
        return try! JSONDecoder().decode(Alert.self, from: text.data(using: .utf8)!)
    }
}
