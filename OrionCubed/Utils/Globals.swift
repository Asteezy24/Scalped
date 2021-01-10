//
//  Globals.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/9/20.
//

import Foundation

enum environments: String {
    case dev = "192.168.0.89"
    case prod = "104.237.146.89"
}

var currEnvironment: environments = .prod
