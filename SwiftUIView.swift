//
//  SwiftUIView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/15/21.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text("a")
            .navigationTitle("SwiftUI")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Press Me") {
                        print("Pressed")
                    }
                }
            }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
