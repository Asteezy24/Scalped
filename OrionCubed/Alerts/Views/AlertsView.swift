//
//  AlertsView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/29/20.
//

import SwiftUI

struct AlertsView: View {
    
    @ObservedObject var viewModel: AlertsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Last 24 Hours")) {
                        ForEach(viewModel.alerts, id: \.self) { alerts in
                            AlertItem(alert: StrategyAlert(action: alerts.action, underlying: alerts.action), strategyName: "Testing")
                        }
                    }
                }
                .navigationBarTitle("Alerts")
                .listStyle(GroupedListStyle())
            }
        }.onAppear(perform: {
            self.viewModel.getAllAlerts()
        })
    }
}

struct AlertsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlertsView(viewModel: AlertsViewModel())
        }
    }
}
