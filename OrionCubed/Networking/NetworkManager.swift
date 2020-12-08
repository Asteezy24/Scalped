//
//  NetworkManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/22/20.
//
import Foundation
import Combine

enum NetworkRequestMethod: String {
    case get = "GET"
    case post = "POST"
}

enum environments: String {
    case dev = "192.168.0.89"
    case prod = "104.237.146.89"
}

// MARK: - Network Controller
protocol NetworkManagerProtocol: class {
    typealias Headers = [String: Any]
    
    func request<T>(type: T.Type,
                    requestType: NetworkRequestMethod,
                    parameters: [String:String],
                    url: URL,
                    headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
    
}

final class NetworkManager: NetworkManagerProtocol {
    
    func request<T: Decodable>(type: T.Type,
                               requestType: NetworkRequestMethod,
                               parameters: [String:String],
                               url: URL,
                               headers: Headers) -> AnyPublisher<T, Error> {
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = httpBody
        request.timeoutInterval = 3
        
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

// MARK: - Debugging Helper
extension CustomStringConvertible where Self: Codable {
    var description: String {
        var description = "\n***** \(type(of: self)) *****\n"
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}
