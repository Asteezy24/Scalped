//
//  Settings.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/19/20.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        VStack {
            HStack {
                Text("View Terms and Conditions")
                Spacer()
            }.padding()
            Divider()
            HStack {
                Text("Feedback and Support")
                Spacer()
            }.padding()
            Divider()
            HStack {
                Text("Version")
                Spacer()
                Text("1.0")
            }.padding()
            Divider()
            Text("Copyright Alexander Stevens")
                .font(.footnote)
            Spacer()
        }
        
        .navigationBarTitle("Settings")
        .navigationBarHidden(false)
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
