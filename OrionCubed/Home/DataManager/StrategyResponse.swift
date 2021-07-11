//
//  StrategyAlertsResponse.swift
//  Scalped
//
//  Created by Alexander Stevens on 12/11/20.
//

import Foundation

struct BaseStrategy: Decodable, Hashable {
    let username: String?
    let timeframe: String?
    let underlyings: [String]
    let identifier: String
    let action: String?
    let isFullWatchlist: Bool?
    let yieldBuyPercent: String?
    let yieldSellPercent: String?
    let priceWhenAdded: String?
}

struct StrategyResponse: Decodable, Hashable  {
    let error: Bool
    let message: String
    let data: [BaseStrategy]
    
}
