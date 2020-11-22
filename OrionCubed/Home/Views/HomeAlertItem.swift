//
//  HomeAlertItem.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import SwiftUI

struct HomeAlertItem: View {
    
    var alert: Alert
    
    var body: some View {
        Text("Alert! You should \(alert.action) \(alert.underlying)")
    }
}

struct HomeAlertItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeAlertItem(alert: Alert(action: "", underlying: ""))
    }
}
