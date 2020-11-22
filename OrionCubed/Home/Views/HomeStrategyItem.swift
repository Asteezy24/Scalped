//
//  HomeStrategyItem.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/14/20.
//

import SwiftUI

struct HomeStrategyItem: View {
    var strategy: Strategy
    var body: some View {
        HStack {
            Text(strategy.strategyName)
        }.padding()
    }
}

struct HomeStrategyItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeStrategyItem(strategy: .init(strategyName: "", strategyUnderlying: "", action: ""))
    }
}
