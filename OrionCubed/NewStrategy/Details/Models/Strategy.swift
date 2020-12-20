//
//  Strategy.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/17/20.
//

import Foundation

struct Strategy: Hashable, Codable, CustomStringConvertible {
    let identifier: String
    let underlying: String
    let action: String
    let timeframe: String
}
