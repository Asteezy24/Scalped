//
//  HomeStrategyItem.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/14/20.
//

import SwiftUI

struct HomeStrategyItem: View {
    
    let strategy: Strategy
    
    var body: some View {
        HStack {
            Text(strategy.identifier)
        }
        .padding()
    }
}

struct HomeStrategyItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeStrategyItem(strategy: .init(identifier: "", underlying: "", action: "", timeframe: ""))
            .preferredColorScheme(.dark)

    }
}
