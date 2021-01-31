//
//  HomeDashboardContent.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/19/20.
//

import SwiftUI

struct HomeDashboardContent: View {
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel:HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.homeScreenBlue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.top)
                VStack {
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
                .background(LinearGradient(gradient: Gradient(colors: [.homeScreenBlue, .white]), startPoint: .top, endPoint: .bottom))
                .navigationTitle(viewModel.determineBannerGreeting())
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("App Name").foregroundColor(.white)
                    }
                })
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
    }
}
