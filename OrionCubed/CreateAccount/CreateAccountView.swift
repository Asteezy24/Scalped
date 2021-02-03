//
//  CreateAccountView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/28/21.
//

import SwiftUI

struct CreateAccountView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: CreateAccountViewModel = CreateAccountViewModel()
    
    @State var username = ""
    @State var password = ""
    @State var confirmedPassword = ""
    @State var accessCode = ""
    
    @State var isLoading = false
    
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if isLoading {
                    ProgressView("Creating user...")
                }
                VStack {
                    Form {
                        Section {
                            TextField("Username", text: $username)
                        }
                        Section(footer: Text("Password must be 8 characters.")) {
                            SecureField("Password", text: $password)
                            SecureField("Confirm Password", text: $confirmedPassword)
                        }
                        Section {
                            TextField("One time access code", text: $accessCode)
                        }
                        Section {
                            HStack {
                                Spacer()
                                Button(action: {self.createAccount()}) {
                                    Text("Submit")
                                        .frame(minWidth: 0, maxWidth: geometry.size.width / 1.5)
                                        .padding()
                                        .cornerRadius(8)
                                        .font(.headline)
                                }
                                Spacer()
                            }
                        }.disabled(formValidation())

                    }
                    .navigationBarTitle(Text("Create an Account"))
                }
                .blur(radius: isLoading ? 4.0 : 0)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Account Creation Failed."),
                          message: Text(alertMessage),
                          dismissButton: .default(Text("Got it!")))
                }
            }
        }
        
    }
    
    private func formValidation() -> Bool {
        return !(self.username != ""
                    && ( self.password == self.confirmedPassword )
                    && self.password != ""
                    && self.password.count >= 8)
    }
    
    private func createAccount() {
        let newUser =  NewUser(username: $username.wrappedValue, password: $password.wrappedValue)
        self.viewModel.submitNewAccount(with: newUser, accessCode: $accessCode.wrappedValue) { success, message in
            $isLoading.wrappedValue = false
            
            if success {
                self.presentationMode.wrappedValue.dismiss()
            } else {
                self.alertMessage = message ?? "Error!"
                self.showingAlert = true
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView(viewModel: CreateAccountViewModel())
    }
}