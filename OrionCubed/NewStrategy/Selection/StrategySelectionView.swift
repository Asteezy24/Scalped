//
//  StrategySelectionView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/8/20.
//

import SwiftUI

struct StrategySelectionView: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @Binding var strategyList: [Strategy]
    @Binding var rootIsActive : Bool
    
    var validStrategies = [
        Strategy(identifier: "GMMA", underlying: "", action: ""),
        Strategy(identifier: "Yield", underlying: "", action: "")
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach((0..<validStrategies.count), id: \.self, content: { index in
                    NavigationLink(destination: NewStrategyView(viewModel: NewStrategyViewModel(strategyName: validStrategies[index].identifier, strategyList: $strategyList), shouldPopToRootView: $rootIsActive)) {
                        StrategySelectionItem(strategy:validStrategies[index].identifier)
                    }.isDetailLink(false)
                })
            }.padding()
        }
    }
}

struct StrategySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        StrategySelectionView(strategyList: .constant([]), rootIsActive: .constant(false))
            .preferredColorScheme(.dark)
    }
}
