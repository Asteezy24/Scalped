//
//  HomeDashboardContent.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/19/20.
//

import SwiftUI

struct HomeDashboardContent: View {
    @State private var bottomSheetShown = false
    @State private var currentPortfolioItem = PortfolioItem(underlying: "", currentPrice: "", currentPL: "", dateBought: "", purchasePrice: "", type: "")
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel:HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        if $viewModel.portfolio.wrappedValue.count > 0 {
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
                            HomePortfolioList(portfolio: $viewModel.portfolio.wrappedValue,
                                              tapAction: { item in
                                                self.bottomSheetShown = true
                                                self.currentPortfolioItem = item
                                                
                                              })
                                .padding(.leading)
                        }
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
                            Text("Scalped")
                        }
                    })
                    .blur(radius: self.bottomSheetShown ? 4.0 : 0.0)

                    BottomSheetView(isOpen: $bottomSheetShown,
                                    maxHeight: self.bottomSheetShown ? 620 : 0) {
                        IndividualPortfolioItemView(item: self.currentPortfolioItem)
                    }
                }
                
            }
        }
        .onAppear(perform: {
            self.viewModel.getAllStrategies()
            self.viewModel.getPortfolio()
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
