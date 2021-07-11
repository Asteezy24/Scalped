//
//  WatchlistResponse.swift
//  Scalped
//
//  Created by Alexander Stevens on 1/9/21.
//

import Foundation

struct WatchlistStockItem: Decodable, Hashable {
    let name: String
    let price: String
    let priceWhenAdded: String
}

struct WatchlistResponse: Decodable, Hashable {    
    let error:Bool
    let message: String
    let data: [WatchlistStockItem]
}

