//
//  AlertItem.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/29/20.
//

import SwiftUI

struct AlertItem: View {
    
    var alert: StrategyAlert
    
    var body: some View {
        VStack {
            determineAlertView(for: alert)
            Button(action:{}) {
                Text(alert.action == "Buy" ? "Buy" : "Sell")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(alert.action == "Buy" ? Color.green : Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }
        }
    }
    
    
    func determineAlertView(for alert: StrategyAlert) -> some View {
        guard let type = TypesOfAlerts(rawValue: alert.typeOfAlert) else { return AnyView(EmptyView()) }
        switch type {
        case .yield:
            return AnyView(yieldAlert(with: alert))
        case .movingAverage:
            return AnyView(movingAverageView(with: alert))
        }
    }
    
}

extension AlertItem {
    func yieldAlert(with alert: StrategyAlert) -> some View {
        AnyView(HStack {
            Image(systemName: alert.action == "Buy" ? "arrow.down.circle.fill": "arrow.up.circle.fill" )
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor( .gray )
            VStack(alignment: .leading) {
                HStack {
                    Text(alert.typeOfAlert)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                }
                Text("\(alert.underlying) \(alert.action == "Sell" ? "went above" : "fell below" ) your yield of 6%. You should consider \(alert.action)ing.")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("1/1/2021 8:53am")
                    .font(.caption)
                Spacer()
            }
        })
    }
    
    func movingAverageView(with alert: StrategyAlert) -> some View {
        AnyView(HStack {
            Image(systemName: alert.action == "Buy" ? "arrow.down.circle.fill": "arrow.up.circle.fill" )
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor( .gray )
            VStack(alignment: .leading) {
                HStack {
                    Text(alert.typeOfAlert)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                }
                Text("\(alert.underlying) had a Guppy \(alert.action) signal.")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("1/1/2021 8:53am")
                    .font(.caption)
                Spacer()
            }
        })
    }
}

struct AlertItem_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AlertItem(alert: StrategyAlert(typeOfAlert: "Moving Average", action: "Buy", underlying: "AAPL"))
            AlertItem(alert: StrategyAlert(typeOfAlert: "Yield", action: "Buy", underlying: "DIS"))
            AlertItem(alert: StrategyAlert(typeOfAlert: "Yield", action: "Sell", underlying: "F"))
        }
    }
}
