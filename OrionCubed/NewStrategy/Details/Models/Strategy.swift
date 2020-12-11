//
//  Strategy.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/17/20.
//

import Foundation

struct Strategy: Hashable, Codable, CustomStringConvertible {
    let identifier: String
    var strategyName: String
    var strategyUnderlying: String
    var action: String
}
