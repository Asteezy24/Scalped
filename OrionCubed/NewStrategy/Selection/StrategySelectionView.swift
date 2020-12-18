//
//  StrategySelectionView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/8/20.
//

import SwiftUI

enum TypesOfStrategies: String {
    case GMMA = "GMMA"
    case yield = "Yield"
}

struct StrategySelectionView: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @Binding var strategyList: [Strategy]
    @Binding var rootIsActive : Bool
    
    var validStrategies = ["GMMA", "Yield"]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach((0..<validStrategies.count), id: \.self, content: { index in
                    NavigationLink(destination: NewStrategyView(viewModel:
                                    NewStrategyViewModel(strategyName: validStrategies[index],
                                                         strategyList: $strategyList),
                                                                shouldPopToRootView: $rootIsActive,
                                                                typeOfStrategy: TypesOfStrategies(rawValue: validStrategies[index]) ?? .GMMA)) {
                        StrategySelectionItem(strategy:validStrategies[index])
                    }
                    .isDetailLink(false)
                })
            }
            .padding()
        }
    }
}

struct StrategySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        StrategySelectionView(strategyList: .constant([]), rootIsActive: .constant(false))
            .preferredColorScheme(.dark)
    }
}
