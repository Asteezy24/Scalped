//
//  StrategySelectionView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/8/20.
//

import SwiftUI

enum TypesOfStrategies: Int {
    case GMMA
    case yield
}

struct StrategySelectionView: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var validStrategies = ["Moving Average", "Yield"] 
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach((0..<validStrategies.count), id: \.self, content: { index in
                        NavigationLink(destination: returnProperSelectionView(with: index)) {
                            StrategySelectionItem(strategy:validStrategies[index])
                                .padding()
                        }
                        .isDetailLink(false)
                    })
                }
                .padding()
            }
            .navigationBarTitle(Text("New Strategy"))
        }
    }
    
    func returnProperSelectionView(with index: Int) -> AnyView {
        let type = TypesOfStrategies(rawValue: index)
        let viewModel = NewStrategyViewModel(strategyName: validStrategies[index])
        
        switch type {
        case .GMMA:
            return AnyView(MovingAverageView(viewModel: viewModel,
                                             typeOfStrategy: type ?? .GMMA))
        case .yield:
            return AnyView(YieldView(viewModel: viewModel))
        case .none:
            return AnyView(EmptyView())
        }
    }
}

struct StrategySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        StrategySelectionView()
            .preferredColorScheme(.dark)
    }
}
