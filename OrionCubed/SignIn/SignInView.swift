//
//  SignInView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/24/21.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewRouter: ViewRouter
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var keyboard = KeyboardResponder()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Spacer()
                    VStack {
                        VStack {
                            HStack {
                                Text("Username")
                                Spacer()
                            }
                            TextField("", text: .constant(""))
                                .padding()
                                .background(Color.white)
                                .cornerRadius(6)
                                .shadow(radius: 5)
                        }.padding(16)
                        VStack {
                            HStack {
                                Text("Password")
                                Spacer()
                            }
                            SecureField("", text: .constant(""))
                                .padding()
                                .background(Color.white)
                                .cornerRadius(6)
                                .shadow(radius: 5)
                        }.padding(16)
                    }
                    Spacer()
                    
                    VStack {
                        NavigationLink(destination: CreateAccountView()) {
                            Text("Create Account >")
                                .frame(minWidth: 0, maxWidth: geometry.size.width / 1.5)
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        Button(action: { viewRouter.currentPage = .home }) {
                            Text("Log In")
                                .padding()
                                .foregroundColor(.gray)
                                .font(.headline)
                            
                        }
                    }
                    Spacer()
                }
                Spacer()
                    .padding(.bottom, self.keyboard.currentHeight)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewRouter: ViewRouter())
    }
}
