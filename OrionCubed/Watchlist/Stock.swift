//
//  Stock.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/30/20.
//

import Foundation

struct Stock: Identifiable {
    let id = UUID()
    let name: String
    let price: String
}