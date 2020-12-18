//
//  TriggerView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/17/20.
//

import SwiftUI

struct TriggerView: View {
    
    @State var firstTrigger = ""
    @State var secondTrigger = ""
    
    var body: some View {
        Section(header: Text("Trigger")) {
            VStack(alignment: .leading) {
                Text("When the...")
                    .font(.body)
                TextField("First trigger", text: $firstTrigger)
                    .padding(.horizontal, 16)
                    .keyboardType(.numberPad)
            }
            VStack(alignment: .leading) {
                Text("Crosses the...")
                    .font(.body)
                TextField("Second trigger", text: $secondTrigger)
                    .padding(.horizontal, 16)
                    .keyboardType(.numberPad)
            }
        }
    }
}

struct TriggerView_Previews: PreviewProvider {
    static var previews: some View {
        TriggerView()
    }
}
