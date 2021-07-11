//
//  Globals.swift
//  Scalped
//
//  Created by Alexander Stevens on 12/9/20.
//

import Foundation

enum environments: String {
    case dev = "192.168.0.89"
    case prod = "45.33.91.40"
}

var currEnvironment: environments = .dev
