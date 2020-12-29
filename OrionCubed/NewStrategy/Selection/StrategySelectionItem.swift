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
        case "Multiple Moving Average":
            return AnyView(Image("Multiple Moving Average"))
        case "Yield":
            return AnyView(Image("Yield"))
        default: return AnyView(EmptyView())
        }
       
    }
}

struct StrategySelectionItem_Previews: PreviewProvider {
    static var previews: some View {
        StrategySelectionItem(strategy: "yield")
    }
}
