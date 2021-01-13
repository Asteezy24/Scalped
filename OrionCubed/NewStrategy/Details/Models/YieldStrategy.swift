//
//  YieldStrategy.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/12/21.
//

import Foundation

struct YieldStrategy: Hashable, Decodable {
    let identifier: String
    let underlyings: [String]
    let yieldBuyGoal: String
    let yieldSellGoal: String
}
