//
//  NetworkManager.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/22/20.
//
import Foundation
import Combine

enum APIError: Error {
    case encode(EncodingError)
    case request(URLError)
    case decode(DecodingError)
    case unknown
}

struct NetworkResponse: Codable {
    let success: Bool
    let message: String
}

// MARK: - Network Controller
protocol NetworkManagerProtocol: class {
    typealias Headers = [String: Any]
    
    func request<T>(type: T.Type,
                url: URL,
                headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
    
}

final class NetworkManager: NetworkManagerProtocol {
    
    func request<T: Decodable>(type: T.Type,
                           url: URL,
                           headers: Headers) -> AnyPublisher<T, Error> {
        
        let parameters: [String: String] = [
            "action" : "foo",
            "underlying": "bar"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
    


// MARK: - Endpoint
/// Reusable base Endpoint struct
struct Endpoint {
    var path: String
}

/// Dummy API specific Endpoint extension
extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "127.0.0.1"
        components.port = 3000
        components.path = path
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    var headers: [String: Any] {
        return [:]
    }
}

/// Dummy API endpoints
extension Endpoint {
    static var createStrategy: Self {
        return Endpoint(path: "/strategy/")
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

// MARK: - Logic Controller
protocol StrategyDataManaging: class {
    var networkManager: NetworkManagerProtocol { get }
    func createStrategy(_ strategy: Strategy)
}
