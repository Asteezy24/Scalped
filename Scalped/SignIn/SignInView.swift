//
//  SignInView.swift
//  Scalped
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
    
    @State var isLoading = false
    
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                if isLoading {
                    ProgressView("Signing you in...")
                }
                
                VStack(spacing: 0) {
                    BadgeSymbol(symbolColor: .purple).frame(width: 225, height: 225)
                    VStack(alignment: .center) {
                        TextField("Username", text: $username)
                            .autocapitalization(.none)
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
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding()
                    }
                    Button(action: { self.signIn() }) {
                        Text("Log In")
                            .padding()
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                    Spacer()
                }
                .blur(radius: isLoading ? 4.0 : 0)
            }
            Spacer()
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Sign In failed."),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("Got it!")))
        }
    }
    
    private func signIn() {
        $isLoading.wrappedValue = true
        self.viewModel.signIn(username: self.username, password: self.password) { success, message in
            $isLoading.wrappedValue = false
            
            if success {
                UserDefaults.standard.set(self.username, forKey: "CurrentUsername")
                UserDefaults.standard.setValue(true, forKey: "IsLoggedIn")
                viewRouter.currentPage = .home
            } else {
                self.alertMessage = message ?? "Error!"
                self.showingAlert = true
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel(), viewRouter: ViewRouter())
    }
}
