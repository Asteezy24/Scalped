//
//  PortfolioResponse.swift
//  Scalped
//
//  Created by Alexander Stevens on 2/1/21.
//

import Foundation

struct PortfolioItem: Decodable, Hashable {
    let underlying: String
    let currentPrice: String
    let currentPL: String
    let dateBought: String
    let purchasePrice: String
    let type: String
}

struct PortfolioResponse: Decodable, Hashable  {
    let error: Bool
    let message: String
    let data: [PortfolioItem]
    
}
