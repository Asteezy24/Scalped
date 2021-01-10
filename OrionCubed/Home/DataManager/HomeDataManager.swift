//
//  HomeAlertDataManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/17/20.
//

import Foundation
import Combine
import SwiftUI

class HomeDataManager: NSObject, ObservableObject {
    @Published var connectedToServer = false
    private lazy var websocketURL = "ws://" + ( currEnvironment == environments.dev ? environments.prod.rawValue : environments.prod.rawValue) + ":1337"
    private var urlSession: URLSession?
    public private(set) var webSocketTask: URLSessionWebSocketTask?
    public private(set) var networkManager = NetworkManager()
    
    override init() {
        super.init()
//        self.urlSession = URLSession(configuration: .default, delegate:self, delegateQueue: OperationQueue())
//        webSocketTask = urlSession?.webSocketTask(with: URL(string: websocketURL)!, protocols: ["echo-protocol"])
//        webSocketTask?.resume()
//        sendPing()
    }
    
    func sendMessage(_ message: String) {
        let message = URLSessionWebSocketTask.Message.string(message)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("WebSocket couldn’t send message because: \(error)")
            }
        }
    }
    
    func listenForUpdates(completion: @escaping (StrategyAlert) -> Void) {
        webSocketTask?.receive {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .failure(let error):
                break
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
    
    @objc private func sendPing() {
        webSocketTask?.sendPing {[weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                print("Error when sending PING\n")
                self.urlSession = URLSession(configuration: .default, delegate:self, delegateQueue: OperationQueue())
                self.webSocketTask = self.urlSession?.webSocketTask(with: URL(string: self.websocketURL)!, protocols: ["echo-protocol"])
                self.webSocketTask?.resume()
                self.sendPing()
                self.connectedToServer = false
            } else {
                self.connectedToServer = true
                print("Web Socket connection is alive")
                DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                    self.sendPing()
                }
            }
        }
    }
    
    func closeConnection() {
        let reason = "Closing connection".data(using: .utf8)
        webSocketTask?.cancel(with: .goingAway, reason: reason)    }
    
    func getAlert(from text: String) -> StrategyAlert {
        return try! JSONDecoder().decode(StrategyAlert.self, from: text.data(using: .utf8)!)
    }
}

// get data from server
extension HomeDataManager {
    
    func getPublisherForAlerts() -> AnyPublisher<AlertResponse, Error> {
        let endpoint = Endpoint.getAlerts
        let parameters: [String: String] = ["username": "alex"]

        return self.networkManager.request(type: AlertResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
    
    func getPublisherForStrategies() -> AnyPublisher<StrategyResponse, Error> {
        let endpoint = Endpoint.getStrategies
        let parameters: [String: String] = ["username": "alex"]

        return self.networkManager.request(type: StrategyResponse.self,
                                           requestType: .post,
                                           parameters: parameters,
                                           url: endpoint.url,
                                           headers: [:])
    }
    
}


extension HomeDataManager: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Web Socket did connect")
        self.connectedToServer = true
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Web Socket did disconnect")
        self.connectedToServer = false
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        self.connectedToServer = false
    }
}
