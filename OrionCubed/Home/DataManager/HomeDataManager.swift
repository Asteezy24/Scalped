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
    private var websocketURL = "ws://192.168.0.89:1337"
    private var urlSession: URLSession?
    public private(set) var webSocketTask: URLSessionWebSocketTask?
    
    override init() {
        super.init()
        self.urlSession = URLSession(configuration: .default, delegate:self, delegateQueue: OperationQueue())
        webSocketTask = urlSession?.webSocketTask(with: URL(string: websocketURL)!, protocols: ["echo-protocol"])
        webSocketTask?.resume()
        sendPing()
    }
    
    func sendMessage(_ message: String) {
        let message = URLSessionWebSocketTask.Message.string(message)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("WebSocket couldn’t send message because: \(error)")
            }
        }
    }
    
    func listenForUpdates(completion: @escaping (Alert) -> Void) {
        webSocketTask?.receive {[weak self] result in
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
    
    @objc private func sendPing() {
        webSocketTask?.sendPing {[weak self] (error) in
            guard let self = self else { return }
            if let error = error {
              print("Error when sending PING \(error)")
            } else {
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
    
    func getAlert(from text: String) -> Alert {
        print("Received: \(text)")
        return try! JSONDecoder().decode(Alert.self, from: text.data(using: .utf8)!)
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
}
