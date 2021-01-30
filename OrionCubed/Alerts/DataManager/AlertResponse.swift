//
//  AlertResponse.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/11/20.
//

import Foundation

struct AlertResponse: Decodable, Hashable {
    let error:Bool
    let message: String
    let data: [StrategyAlert]
}

struct StrategyAlert: Decodable, Hashable {
    var typeOfAlert: String
    var action: String
    var underlying: String
}

enum TypesOfAlerts: String {
    case yield = "Yield"
    case movingAverage = "Moving Average"
}
