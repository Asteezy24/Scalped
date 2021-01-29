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
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    HStack {
                        Text("Username")
                        Spacer()
                    }
                    TextField("", text: $viewModel.username)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(6)
                        .shadow(radius: 5)
                }.padding(16)
                VStack {
                    HStack {
                        Text("Password")
                        Spacer()
                    }
                    TextField("", text: $viewModel.password)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(6)
                        .shadow(radius: 5)
                }.padding(16)
                VStack {
                    HStack {
                        Text("Confirm Password")
                        Spacer()
                    }
                    TextField("", text: $viewModel.confirmedPassword)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(6)
                        .shadow(radius: 5)
                }.padding(16)
                Spacer()
                Button(action: {self.createAccount()}) {
                    Text("Submit >")
                        .frame(minWidth: 0, maxWidth: geometry.size.width / 1.5)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .font(.headline)
                }

            }
            .navigationBarTitle(Text("Create an Account"))
        }

    }
    
    private func createAccount() {
        self.viewModel.submitNewAccount { success in
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
