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
    var environment: environments = .dev
}

/// Dummy API specific Endpoint extension
extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = self.environment == .dev ? environments.dev.rawValue : environments.dev.rawValue
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
    static var sendDeviceId: Self {
        return Endpoint(path: "/notification/provider")
    }
}
