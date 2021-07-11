//
//  ViewRouter.swift
//  Scalped
//
//  Created by Alexander Stevens on 1/24/21.
//

import Foundation
import Combine

enum Routes {
    case logIn
    case home
}

class ViewRouter: ObservableObject {
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    var currentPage: Routes = .logIn {
        didSet {
            objectWillChange.send(self)
        }
    }
}
