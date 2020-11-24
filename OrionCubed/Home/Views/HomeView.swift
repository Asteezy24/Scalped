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
                        ForEach(viewModel.alerts.reversed(), id: \.self) { alert in
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
                NavigationLink(destination: NewStrategyView(viewModel: NewStrategyViewModel(strategyList: $viewModel.strategies))) {
                    Text("Add Strategy")
                }
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
