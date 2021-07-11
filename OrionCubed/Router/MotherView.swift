//
//  MotherView.swift
//  Scalped
//
//  Created by Alexander Stevens on 1/24/21.
//

import SwiftUI

struct MotherView: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == .logIn && !(UserDefaults.standard.value(forKey: "IsLoggedIn") as? Bool ?? false) {
                SignInView(viewModel: SignInViewModel(),
                           viewRouter: viewRouter)
            } else if viewRouter.currentPage == .home || UserDefaults.standard.value(forKey: "IsLoggedIn") as? Bool ?? false {
                HomeView(viewRouter: viewRouter)
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewRouter: ViewRouter())
    }
}
