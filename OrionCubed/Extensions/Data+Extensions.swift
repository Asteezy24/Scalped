//
//  Data+Extensions.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/29/21.
//

import Foundation

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
