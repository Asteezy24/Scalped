//
//  HomeStrategyItem.swift
//  Scalped
//
//  Created by Alexander Stevens on 11/14/20.
//

import SwiftUI

struct MovingAverageStrategyView: View {
    
    let strategy: BaseStrategy
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color.green)
                .frame(height: 12)
            HStack {
                Text("")
                    .font(.title)
                    .padding()
                Spacer()
            }
            .padding(.trailing, 16)
            HStack {
                Text(strategy.identifier)
                    .font(.subheadline)
                    .padding()
                Spacer()
                Text("ACTION HERE")
                    .padding(8)
                    .background(Color.gray)
                    .foregroundColor(.white)
            } .padding(.trailing, 16)
        }
        .background(Color.gray)
    }
}

struct HomeStrategyItem_Previews: PreviewProvider {
    static var previews: some View {
        List {
            MovingAverageStrategyView(strategy: BaseStrategy(username: "", timeframe: "", underlyings: [], identifier: "", action: "", isFullWatchlist: nil, yieldBuyPercent: "", yieldSellPercent: "", priceWhenAdded: nil))
                .preferredColorScheme(.dark)
        }
    }
}
