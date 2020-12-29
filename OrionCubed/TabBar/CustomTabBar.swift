//
//  CustomTabBar.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/19/20.
//

import SwiftUI


enum TabBarRoutes {
    case home
    case watchlist
    case alerts
    case settings
}

enum ActiveSheets {
    case plusMenu
}

struct CustomTabBar: View {
    @Binding var currentView: TabBarRoutes
    @Binding var showModal: Bool
    @Binding var currentSheet: ActiveSheets
    
    var body: some View {
        HStack {
            TabBarItem(currentView: self.$currentView, imageName: "house.fill", tab: .home)
            Spacer()
            TabBarItem(currentView: self.$currentView, imageName: "line.horizontal.3", tab: .watchlist)
            Spacer()
            TabBarMiddleItem(radius: 50) {
                self.showModal.toggle()
                self.currentSheet = .plusMenu
            }
            Spacer()
            TabBarItem(currentView: self.$currentView, imageName: "bell", tab: .alerts)
            Spacer()
            TabBarItem(currentView: self.$currentView, imageName: "gear", tab: .settings)
        }
        .frame(minHeight: 70)
        .padding()
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(currentView: .constant(.home), showModal: .constant(false), currentSheet: .constant(.plusMenu))
    }
}
