//
//  HomeDashboardContent.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/19/20.
//

import SwiftUI

struct HomeDashboardContent: View {
    @State private var bottomSheetShown = false
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel:HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        HStack {
                            Text("Portfolio")
                                .font(.footnote)
                                .padding(8)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(35)
                            Spacer()
                        }
                        .padding()
                        HomePortfolioList(tapAction: {self.bottomSheetShown = true}).padding(.leading)
                        HStack {
                            Text("Strategies")
                                .font(.footnote)
                                .padding(8)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(35)
                            Spacer()
                        }
                        .padding()
                        HomeStrategyList(strategies: $viewModel.strategies.wrappedValue)
                    }
                    .background(LinearGradient(gradient: Gradient(colors: [.homeScreenBlue, .white, .homeScreenBlue, .white]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.top))
                    .navigationTitle(viewModel.determineBannerGreeting())

                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("App Name")
                        }
                    })
                    .blur(radius: self.bottomSheetShown ? 4.0 : 0.0)

                    BottomSheetView(isOpen: $bottomSheetShown,
                                    maxHeight: self.bottomSheetShown ? 350 : 0) {
                        Color.blue
                    }
                }
                
            }
        }
        .onAppear(perform: {
            self.viewModel.getAllStrategies()
            self.viewModel.sendDeviceTokenToServer()
        })
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.top)
    }
}

struct HomeDashboardContent_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeDashboardContent(viewModel: HomeViewModel())
        HomeDashboardContent(viewModel: HomeViewModel())
            .preferredColorScheme(.dark)
        SignInView(viewModel: SignInViewModel(), viewRouter: ViewRouter())

    }
}
