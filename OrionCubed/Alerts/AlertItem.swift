//
//  AlertItem.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/29/20.
//

import SwiftUI

struct AlertItem: View {
    
    var alert: StrategyAlert
    var typeOfStrategy: String
    
    var body: some View {
        HStack {
            Image(systemName: alert.action == "Buy" ? "arrow.down.circle.fill": "arrow.up.circle.fill" )
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor( alert.action == "Buy" ? .red : .green )
            VStack {
                Text(typeOfStrategy)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                Text("\(alert.underlying) \(alert.action == "Sell" ? "went above" : "fell below" ) your yield of 6%. You should consider \(alert.action)ing.")
                    .font(.headline)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("1/1/2021 8:53am")
                    .font(.caption)
                Spacer()
            }
        }
    }
}

struct AlertItem_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AlertItem(alert: StrategyAlert(action: "Buy", underlying: "AAPL"), typeOfStrategy: "Yield")
            AlertItem(alert: StrategyAlert(action: "Buy", underlying: "DIS"), typeOfStrategy: "GMMA")
            AlertItem(alert: StrategyAlert(action: "Sell", underlying: "F"), typeOfStrategy: "GMMA")

        }
    }
}
