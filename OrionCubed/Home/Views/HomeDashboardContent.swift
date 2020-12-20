//
//  HomeDashboardContent.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/19/20.
//

import SwiftUI

struct HomeDashboardContent: View {
    
    @ObservedObject var viewModel: HomeViewModel
    let action: () -> Void

    
    
    var body: some View {
        List {
            Section(header: Text("Alerts")) {
                ForEach(viewModel.alerts.reversed().prefix(5), id: \.self) { alert in
                    HomeAlertItem(alert: alert)
                }
            }
            Section(header: Text("Strategies")) {
                ForEach(viewModel.strategies, id: \.self) { strategy in
                    HomeStrategyItem(strategy: strategy)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Orion Cubed")
        .navigationBarItems(trailing:
              HStack {
                Text("Server Connection: ")
                    .font(.subheadline)
                    .fixedSize()
               Circle()
                .fill($viewModel.connectedToServer.wrappedValue ? Color.green : Color.red)
              }.padding())
        .onAppear(perform: {
            self.viewModel.getAllStrategies()
            self.viewModel.getAllAlerts()
        })
    }
}

struct HomeDashboardContent_Previews: PreviewProvider {
    static var previews: some View {
        HomeDashboardContent(viewModel: HomeViewModel(), action: {})
    }
}
