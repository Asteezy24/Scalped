//
//  SignInView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/24/21.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    @ObservedObject var viewRouter: ViewRouter
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var keyboard = KeyboardResponder()
    
    @State var username = ""
    @State var password = ""

    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Image(systemName: "command.circle.fill")
                    .resizable()
                    .frame(width: 125, height: 125)
                    .padding(.bottom)
                
                VStack(alignment: .center) {
                    TextField("Username", text: $username)
                        .multilineTextAlignment(TextAlignment.center)
                        .padding(.vertical)
                    
                    VStack {
                        SecureField("Password", text: $password)
                            .multilineTextAlignment(TextAlignment.center)
                            .padding(.vertical)
                        
                    }
                }.padding(.top)
                
                
                Spacer()
                
                NavigationLink(destination: CreateAccountView()) {
                    Text("Create Account")
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .font(.headline)
                }
                Button(action: { self.signIn() }) {
                    Text("Log In")
                        .padding()
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                Spacer()
            }
            Spacer()
        }
    }
    
    private func signIn() {
        self.viewModel.signIn(username: self.username,
                              password: self.password) { success in
            if success {
                viewRouter.currentPage = .home
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel(), viewRouter: ViewRouter())
    }
}
