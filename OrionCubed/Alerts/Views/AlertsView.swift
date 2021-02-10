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
                        ForEach(viewModel.alerts, id: \.self) { alert in
                            AlertItem(alert: alert, tapAction: { 
                                self.viewModel.actionSignaled(alert: alert)
                            })
                        }
                    }
                }
                .navigationTitle("Alerts")
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
