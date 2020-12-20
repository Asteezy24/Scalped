//
//  CustomTabBar.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/19/20.
//

import SwiftUI


enum TabBarRoutes {
    case home
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
            TabBarItem(currentView: self.$currentView, imageName: "line.horizontal.3", paddingEdges: .trailing, tab: .home)
            Spacer()
            TabBarMiddleItem(radius: 50) {
                self.showModal.toggle()
                self.currentSheet = .plusMenu
            }
            Spacer()
            TabBarItem(currentView: self.$currentView, imageName: "gear", paddingEdges: .trailing, tab: .settings)
        }
        .frame(minHeight: 70)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(currentView: .constant(.home), showModal: .constant(false), currentSheet: .constant(.plusMenu))
    }
}
