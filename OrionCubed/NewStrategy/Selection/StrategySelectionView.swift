//
//  StrategySelectionView.swift
//  Scalped
//
//  Created by Alexander Stevens on 12/8/20.
//

import SwiftUI

struct StrategySelectionView: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var validStrategies = ["Moving Average", "Yield"]
    
    enum TypesOfStrategies: Int {
        case GMMA
        case yield
    }
    
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
        guard let type = TypesOfStrategies(rawValue: index) else { return AnyView(EmptyView())}
        let viewModel = NewStrategyViewModel(strategyName: validStrategies[index])
        
        switch type {
        case .GMMA:
            return AnyView(MovingAverageView(viewModel: viewModel))
        case .yield:
            return AnyView(YieldView(viewModel: viewModel))
        }
    }
}

struct StrategySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        StrategySelectionView()
            .preferredColorScheme(.dark)
    }
}
