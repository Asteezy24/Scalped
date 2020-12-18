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
        Text(strategy)
    }
}

struct StrategySelectionItem_Previews: PreviewProvider {
    static var previews: some View {
        StrategySelectionItem(strategy: "bugha")
    }
}
