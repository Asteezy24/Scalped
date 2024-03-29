//
//  Endpoint.swift
//  Scalped
//
//  Created by Alexander Stevens on 11/25/20.
//

import Foundation

// MARK: - Endpoint
/// Reusable base Endpoint struct
struct Endpoint {
    var path: String
}

/// API specific Endpoint extension
extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = currEnvironment == .dev ? environments.dev.rawValue : environments.prod.rawValue
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

/// API endpoints
extension Endpoint {
    static var getSymbols: Self {
        return Endpoint(path: "/api/symbols")
    }
    static var getAlerts: Self {
        return Endpoint(path: "/api/alerts")
    }
    static var getStrategies: Self {
        return Endpoint(path: "/api/strategy")
    }
    static var getWatchlist: Self {
        return Endpoint(path: "/api/watchlist")
    }
    static var addToWatchlist: Self {
        return Endpoint(path: "/api/watchlist/add")
    }
    static var deleteFromWatchlist: Self {
        return Endpoint(path: "/api/watchlist/delete")
    }
    static var createStrategy: Self {
        return Endpoint(path: "/api/strategy/create")
    }
    static var sendDeviceId: Self {
        return Endpoint(path: "/api/notification/updateToken")
    }
    static var createUser: Self {
        return Endpoint(path: "/api/users/signup")
    }
    static var signIn: Self {
        return Endpoint(path: "/api/users/signin")
    }
    static var getPortfolio: Self {
        return Endpoint(path: "/api/portfolio")
    }
    static var addToPortfolio: Self {
        return Endpoint(path: "/api/portfolio/buy")
    }
}
