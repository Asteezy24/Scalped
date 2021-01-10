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
        VStack {
            Rectangle()
                .foregroundColor(self.strategy.action == "Sell" ? Color.red : Color.green)
                .frame(height: 12)
            HStack {
                Text(strategy.underlying)
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
                Text(strategy.action)
                    .padding(8)
                    .background(Color.gray)
                    .foregroundColor(.white)
            } .padding(.trailing, 16)
        }
        .background(Color.gray)
        //.cornerRadius(8)
        //.shadow(radius: 8)
    }
}

struct HomeStrategyItem_Previews: PreviewProvider {
    static var previews: some View {
        List {
        HomeStrategyItem(strategy: .init(identifier: "1", underlying: "2", action: "3", timeframe: "4"))
            .preferredColorScheme(.dark)
        }
    }
}
