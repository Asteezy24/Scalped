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
        
        VStack(alignment: .leading) {
            HStack {
                Text("Hello, \nAlex Stevens")
                    .font(.system(size: 34, weight: .heavy))
                Spacer()
            }.padding()
        }
        
        Form {
            //            Section(header: Text("Alerts")) {
            //                ForEach(viewModel.alerts.reversed().prefix(5), id: \.self) { alert in
            //                    HomeAlertItem(alert: alert)
            //                }
            //            }
            Section(header: Text("Strategies")) {
                HStack(spacing: 20) {
                    ForEach(viewModel.strategies, id: \.self) { strategy in
                        HomeStrategyItem(strategy: strategy)
                    }
                }
                
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(leading: Text("Dashboard"),
                            trailing:
                                HStack {
                                    Text("Server Connection: ")
                                        .font(.subheadline)
                                        .fixedSize()
                                    Circle()
                                        .fill($viewModel.connectedToServer.wrappedValue ? Color.green : Color.red)
                                    Image(systemName:"person.crop.square")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                }
                                .padding())
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
