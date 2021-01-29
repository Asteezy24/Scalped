//
//  Settings.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 12/19/20.
//

import SwiftUI

let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

struct Settings: View {
    
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination:
                                WebView()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .navigationBarTitle("Terms & Conditions", displayMode: .inline)) {
                    HStack {
                        Text("View Terms and Conditions")
                        Spacer()
                    }.padding()
                }
                HStack {
                    Text("Version")
                    Spacer()
                    Text(appVersionString)
                }.padding()
                HStack {
                    Spacer()
                    Button(action: { viewRouter.currentPage = .logIn }) {
                        Text("Sign Out")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding()
                    }
                    Spacer()
                }
                Text("© Copyright Alexander Stevens")
                    .font(.footnote)
            }
            .navigationTitle("Settings")
            .listStyle(InsetListStyle())
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(viewRouter: ViewRouter())
    }
}
