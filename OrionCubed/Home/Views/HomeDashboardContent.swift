//
//  HomeDashboardContent.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/19/20.
//

import SwiftUI

struct HomeDashboardContent: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Strategies")
                        .font(.footnote)
                        .padding(8)
                        .background(Color.blue)
                        .cornerRadius(35)
                    Spacer()
                }.padding()
                HomeStrategyList(strategies: $viewModel.strategies.wrappedValue)
                Spacer()
            }
            .navigationTitle(viewModel.determineBannerGreeting())
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("App Name")
                }
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    HStack {
                        Image(systemName:"person.crop.square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                    .padding()
                })
            })
        }.onAppear(perform: {
            self.viewModel.getAllStrategies()
        })
    }
}

struct HomeDashboardContent_Previews: PreviewProvider {
    static var previews: some View {
        HomeDashboardContent(viewModel: HomeViewModel())
    }
}
