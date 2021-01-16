//
//  Strategy.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/17/20.
//

import Foundation

struct MovingAverageStrategy:  Hashable, Codable {
    let identifier: String
    let underlyings: [String]
    let action: String
    let timeframe: String
}
