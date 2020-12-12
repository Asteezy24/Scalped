//
//  Endpoint.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/25/20.
//

import Foundation

// MARK: - Endpoint
/// Reusable base Endpoint struct
struct Endpoint {
    var path: String
}

/// Dummy API specific Endpoint extension
extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = currEnvironment == .dev ? environments.dev.rawValue : environments.prod.rawValue
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
    static var getAlerts: Self {
        return Endpoint(path: "/api/alerts")
    }
    static var getStrategies: Self {
        return Endpoint(path: "/api/strategy")
    }
    static var createStrategy: Self {
        return Endpoint(path: "/api/strategy/create")
    }
    static var sendDeviceId: Self {
        return Endpoint(path: "/api/notification/updateToken")
    }
}
