//
//  AlertsView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/29/20.
//

import SwiftUI

struct AlertsView: View {
    var body: some View {
        List {
            Section(header: Text("Last 24 Hours")) {
                AlertItem(alert: StrategyAlert(action: "Buy", underlying: "$AAPL"), typeOfStrategy: "Yield Strategy")
            }
            Section(header: Text("Older")) {
                AlertItem(alert: StrategyAlert(action: "Buy", underlying: "$AAPL"), typeOfStrategy: "Multiple Moving Average")
                AlertItem(alert: StrategyAlert(action: "Sell", underlying: "$AAPL"), typeOfStrategy: "Multiple Moving Average")
                AlertItem(alert: StrategyAlert(action: "Buy", underlying: "$AAPL"), typeOfStrategy: "Yield Strategy")
                AlertItem(alert: StrategyAlert(action: "Sell", underlying: "$AAPL"), typeOfStrategy: "Yield Strategy")
                AlertItem(alert: StrategyAlert(action: "Buy", underlying: "$AAPL"), typeOfStrategy: "Multiple Moving Average")
                AlertItem(alert: StrategyAlert(action: "Buy", underlying: "$AAPL"), typeOfStrategy: "Yield Strategy")
                AlertItem(alert: StrategyAlert(action: "Sell", underlying: "$AAPL"), typeOfStrategy: "Yield Strategy")

            }
        }.listStyle(GroupedListStyle())
    }
}

struct AlertsView_Previews: PreviewProvider {
    static var previews: some View {
        AlertsView()
    }
}
