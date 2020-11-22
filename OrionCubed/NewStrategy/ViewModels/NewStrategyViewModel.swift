//
//  NewStrategyViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import SwiftUI

struct NewStrategyViewModel {
    @Binding var strategyList: [Strategy]
    var dataManager = NewStrategyDataManager()
    
    func saveStrategy(_ strategy: Strategy) {
        strategyList.append(strategy)
        self.dataManager.sendNewStrategyToServer(strategy)
    }
}
