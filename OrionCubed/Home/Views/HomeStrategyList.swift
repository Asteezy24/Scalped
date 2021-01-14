//
//  HomeStrategyList.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/13/21.
//

import SwiftUI

struct HomeStrategyList: View {
    
    var strategies: [BaseStrategy]
    
    var body: some View {
        List {
            ForEach((0..<strategies.count), id: \.self, content: { index in
                if strategies[index].identifier == "Yield" {
                    returnYieldView(from: strategies[index])
                } else {
                    returnMVView(from: strategies[index])
                }
            })
        }.listStyle(InsetListStyle())
    }
    
    func returnMVView(from strat: BaseStrategy) -> AnyView {
        return AnyView(
            Section {
                DisclosureGroup {
                    HStack {
                        Text("Underlying: ")
                        Spacer()
                        Text(strat.underlyings[0])
                    }
                    HStack {
                        Text("Action: ")
                        Spacer()
                        Text(strat.action)
                    }
                    HStack {
                        Text("Timeframe: ")
                        Spacer()
                        Text(strat.timeframe)
                    }
                } label: {
                    Text("Multiple Moving Average")
                        .font(.headline)
                }
            }
        )
    }
    
    
    func returnYieldView(from strat: BaseStrategy) -> AnyView {
        return AnyView(
            Section {
                DisclosureGroup {
                    DisclosureGroup {
                        ForEach((0..<strat.underlyings.count), id: \.self, content: { index in
                            HStack {
                                Text("Underlying: ")
                                Spacer()
                                Text("\(strat.underlyings[index])")
                            }
                            
                        })
                    } label: {
                        Text("Underlyings")
                            .font(.headline)
                    }
                    HStack {
                        Text("Yield Buy Goal: ")
                        Spacer()
                        Text("\(strat.yieldBuyPercent)%")
                    }
                    HStack {
                        Text("Yield Sell Goal: ")
                        Spacer()
                        Text("\(strat.yieldSellPercent)%")
                    }
                } label: {
                    Text("Yield Strategy")
                        .font(.headline)
                }
            }
        )
    }
    
}

struct HomeStrategyList_Previews: PreviewProvider {
    static var previews: some View {
        HomeStrategyList(strategies:[
                            BaseStrategy(timeframe: "", underlyings: ["AAPL", "SPY"], identifier: "Yield", action: "", yieldBuyPercent: "6", yieldSellPercent: "6"),
                            BaseStrategy(timeframe: "1H", underlyings: ["SPY"], identifier: "Moving Average", action: "Buy", yieldBuyPercent: "", yieldSellPercent: ""),
                            BaseStrategy(timeframe: "1H", underlyings: ["SPY"], identifier: "Moving Average", action: "Buy", yieldBuyPercent: "", yieldSellPercent: "")
                        ])
    }
}
