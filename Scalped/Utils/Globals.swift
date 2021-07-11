//
//  Globals.swift
//  Scalped
//
//  Created by Alexander Stevens on 12/9/20.
//

import Foundation

enum environments: String {
    case dev = "192.168.0.89"
    case prod = "api.tryscalped.com"
}

var currEnvironment: environments = .prod
