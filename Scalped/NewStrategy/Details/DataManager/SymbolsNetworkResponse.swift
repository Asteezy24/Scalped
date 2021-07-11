//
//  SymbolsNetworkResponse.swift
//  Scalped
//
//  Created by Alexander Stevens on 12/15/20.
//

import Foundation

struct SymbolsNetworkResponse: Hashable, Decodable {
    let error:Bool
    let message: String
    let data: [String]
}
