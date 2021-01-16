//
//  StrategySelectionItem.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/17/20.
//

import SwiftUI

struct StrategySelectionItem: View {
    
    var strategy: String
    
    var body: some View {
        VStack {
            image(for: strategy)
                .foregroundColor(.white)
            Divider()
                .padding()
            Text(strategy)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
    }
    
    func image(for strategy: String) -> AnyView {
        switch strategy {
        case "Moving Average":
            return AnyView(
                Image(systemName: "alt")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding()
            )
        case "Yield":
            return AnyView(
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding()
            )
        default: return AnyView(EmptyView())
        }
        
    }
}

struct StrategySelectionItem_Previews: PreviewProvider {
    static var previews: some View {
        StrategySelectionItem(strategy: "Yield")
    }
}
