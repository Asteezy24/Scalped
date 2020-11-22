//
//  UIApplication+Extensions.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/17/20.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
