//
//  HomeView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/14/20.
//

import SwiftUI
import Combine

struct HomeView: View {
    @State var isActive : Bool = false
//    @State private var strategyDetailPresented = false
//    @State private var currentView: TabBarRoutes = .home
    @State private var showModal: Bool = false
//    @State private var currentSheet: ActiveSheets = .plusMenu
    
    var body: some View {
        VStack {
            TabView {
                HomeDashboardContent(viewModel: HomeViewModel(), action: {
                    self.showModal.toggle()
                })
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                WatchlistView()
                    .tabItem {
                        Image(systemName: "line.horizontal.3")
                        Text("Watchlist")
                    }
                
                StrategySelectionView(rootIsActive: $showModal)
                    .tabItem {
                        Image(systemName: "plus").resizable()
                        Text("Create New")
                    }
                
                AlertsView()
                    .tabItem {
                        Image(systemName: "bell")
                        Text("Alerts")
                    }
                Settings()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
        }
//        .sheet(isPresented: self.$showModal) {
//            if self.currentSheet == .plusMenu {
//                StrategySelectionView(rootIsActive: $isActive)
//            }
//        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
