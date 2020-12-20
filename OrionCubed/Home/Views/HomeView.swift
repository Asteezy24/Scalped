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
    @State private var strategyDetailPresented = false
    @State private var currentView: TabBarRoutes = .home
    @State private var showModal: Bool = false
    @State private var currentSheet: ActiveSheets = .plusMenu
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    CurrentTabBarScreen(currentView: self.$currentView, showModal: self.$showModal, currentSheet: self.$currentSheet)
                    CustomTabBar(currentView: self.$currentView, showModal: self.$showModal, currentSheet: self.$currentSheet)
                }
            }
        }
        .sheet(isPresented: self.$showModal) {
            if self.currentSheet == .plusMenu {
                StrategySelectionView(rootIsActive: $isActive)
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
