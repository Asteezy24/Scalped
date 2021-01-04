//
//  HomeDashboardContent.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/19/20.
//

import SwiftUI


struct HomeDashboardContent: View {
    @ObservedObject var viewModel: HomeViewModel
    let action: () -> Void
    
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
                    //                Button(action: {
                    //                    print("")
                    //                }) {
                    //                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
                    //                        .resizable()
                    //                        .foregroundColor(Color.gray)
                    //                        .frame(width: 25, height: 25)
                    //                }
                    
                }.padding()
                VStack(spacing: 20) {
                    ForEach(viewModel.strategies, id: \.self) { strategy in
                        HomeStrategyItem(strategy: strategy)
                    }
                }.padding()
                Spacer()
            }
            .navigationBarTitle("Good Morning!")
            .navigationBarItems(leading: Text("App Name"),
                                trailing:
                                    HStack {
                                        Text("Server Connection: ")
                                            .font(.subheadline)
                                            .fixedSize()
                                        Circle()
                                            .fill($viewModel.connectedToServer.wrappedValue ? Color.green : Color.red)
                                        Image(systemName:"person.crop.square")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                    }
                                    .padding())
            .onAppear(perform: {
                self.viewModel.getAllStrategies()
                self.viewModel.getAllAlerts()
            })
        }
    }
}

struct HomeDashboardContent_Previews: PreviewProvider {
    static var previews: some View {
        HomeDashboardContent(viewModel: HomeViewModel(), action: {})
    }
}
