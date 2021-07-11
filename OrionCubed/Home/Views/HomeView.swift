//
//  HomeView.swift
//  Scalped
//
//  Created by Alexander Stevens on 11/14/20.
//

import SwiftUI
import Combine

struct HomeView: View {
    @State private var tabBarSelection = 0
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            TabView(selection: $tabBarSelection) {
                HomeDashboardContent(viewModel: HomeViewModel())
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                WatchlistView(viewModel: WatchlistViewModel())
                    .tabItem {
                        Image(systemName: "line.horizontal.3")
                        Text("Watchlist")
                    }
                
                StrategySelectionView()
                    .tabItem {
                        Image(systemName: "plus").resizable()
                        Text("Discover")
                    }
                
                AlertsView(viewModel: AlertsViewModel())
                    .tabItem {
                        Image(systemName: "bell")
                        Text("Alerts")
                    }
                Settings(viewRouter: viewRouter)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewRouter: ViewRouter())
    }
}
