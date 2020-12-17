//
//  NewStrategyView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import SwiftUI

struct NewStrategyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: NewStrategyViewModel
    
    var body: some View {
        let serviceError = Binding<Bool>(
            get: { self.viewModel.errorAlert  },
            set: { _ in self.viewModel.errorAlert = true }
        )
        VStack {
            Form {
                Section(header: Text("Identifiers")) {
                    //TextField("Strategy Name", text: $viewModel.strategyName)
                    TextField("Underlying", text: $viewModel.underlyingEntry)
                }
                
                showEmptyOrList()
                
//                Section(header: Text("Trigger")) {
//                    VStack(alignment: .leading) {
//                        Text("When the...")
//                            .font(.body)
//                        TextField("First trigger", text: $firstTrigger)
//                            .padding(.horizontal, 16)
//                            .keyboardType(.numberPad)
//                    }
//                    VStack(alignment: .leading) {
//                        Text("Crosses the...")
//                            .font(.body)
//                        TextField("Second trigger", text: $secondTrigger)
//                            .padding(.horizontal, 16)
//                            .keyboardType(.numberPad)
//                    }
//                }
                
                Section(header: Text("Action")) {
                    Picker("", selection: $viewModel.actionSelected) {
                        ForEach(0 ..< viewModel.strategyActions.count) {
                            Text("\(viewModel.strategyActions[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Button(action: {self.saveStrategyAndDismiss()}, label: {
                Text("Save")
            })
        }
        .navigationBarTitle(Text("New Strategy"))
        .alert(isPresented: serviceError) {
            Alert(title: Text("Error!"), message: Text("Cannot Save this strategy"), dismissButton: .default(Text("Dismiss")))
        }
    }
    
    var searchResultsList: some View {
        ForEach(viewModel.searchResults, content: { symbol in
            VStack {
                HStack {
                    Text(symbol.name)
                }.onTapGesture {
                    viewModel.selectedUnderlying = true
                    viewModel.underlyingEntry = symbol.name
                    UIApplication.shared.endEditing()
                }
            }
        })
    }
    
    private func showEmptyOrList() -> some View {
        switch $viewModel.selectedUnderlying.wrappedValue {
        case true:
            return AnyView(EmptyView())
        case false:
            return AnyView(searchResultsList)
        }
    }
    
    private func saveStrategyAndDismiss() {
        self.presentationMode.wrappedValue.dismiss()
        self.viewModel.saveStrategy()
    }
}

struct NewStrategyView_Previews: PreviewProvider {
    static var previews: some View {
        NewStrategyView(viewModel: NewStrategyViewModel(strategyList: .constant([])))
    }
}
