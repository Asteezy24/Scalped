//
//  CurrentTabBarScreen.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/19/20.
//

import SwiftUI

struct CurrentTabBarScreen: View {
    @Binding var currentView: TabBarRoutes
    @Binding var showModal: Bool
    @Binding var currentSheet: ActiveSheets
    
    var body: some View {
        VStack {
            if self.currentView == .home {
                HomeDashboardContent(viewModel: HomeViewModel(), action: {
                    self.showModal.toggle()
                })
            }
            else if self.currentView == .alerts {
                AlertsView()
            } else if self.currentView == .watchlist {
                WatchlistView()
            } else if self.currentView == .settings {
                Settings()
            }
        }
    }
}

struct CurrentTabBarScreen_Previews: PreviewProvider {
    static var previews: some View {
        CurrentTabBarScreen(currentView: .constant(.home), showModal: .constant(false), currentSheet: .constant(.plusMenu))
    }
}
