//
//  WatchlistResponse.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/9/21.
//

import Foundation

struct WatchlistResponse: Decodable, Hashable {    
    let error:Bool
    let message: String
    let data: [Stock]
}

