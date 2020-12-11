//
//  HomeView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/14/20.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @State private var strategyDetailPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
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
                      }.padding()
                                    
                )
                NavigationLink(destination: NewStrategyView(viewModel: NewStrategyViewModel(strategyList: $viewModel.strategies))) {
                    Text("Add Strategy")
                }
            }
            .onAppear(perform: {
                self.viewModel.getAllStrategies()
            })
        }
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
