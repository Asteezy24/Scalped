//
//  TabBarItem.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/19/20.
//

import SwiftUI

struct TabBarItem: View {
    
    @Binding var currentView: TabBarRoutes
    let imageName: String
    let paddingEdges: Edge.Set
    let tab: TabBarRoutes
    
    var body: some View {
        VStack(spacing:0) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(5)
                .frame(width: 40, height: 40, alignment: .center)
                .background(Color(self.currentView == tab ? .blue : .white).opacity(0.2))
                .foregroundColor(Color(self.currentView == tab ? .blue : .black))
                .cornerRadius(6)
        }
        .frame(width: 100, height: 50)
        .onTapGesture { self.currentView = self.tab }
        .padding(paddingEdges, 15)
    }
}

struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItem(currentView: .constant(.home), imageName: "gear", paddingEdges: .leading, tab: .home)
    }
}
