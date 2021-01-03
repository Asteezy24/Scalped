//
//  StrategyAlertsResponse.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/11/20.
//

import Foundation

struct StrategyResponse: Decodable, Hashable  {
    let error: Bool
    let message: String
    let data: [Strategy]
//    let timeframe: String
}
