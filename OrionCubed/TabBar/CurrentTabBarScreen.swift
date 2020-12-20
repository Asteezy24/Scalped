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
            } else {
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
