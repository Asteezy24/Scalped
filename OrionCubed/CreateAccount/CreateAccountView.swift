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
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Form {
                    Section {
                        TextField("Username", text: $username)
                    }
                    Section {
                        SecureField("Password", text: $password)
                        SecureField("Confirm Password", text: $confirmedPassword)
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
                    }
                    .disabled(formValidation())
                }
                .navigationBarTitle(Text("Create an Account"))
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
        self.viewModel.submitNewAccount(with: NewUser(username: $username.wrappedValue, password: $password.wrappedValue)) { success in
            if success {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView(viewModel: CreateAccountViewModel())
    }
}
