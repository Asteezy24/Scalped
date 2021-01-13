//
//  NewStrategyView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import SwiftUI

struct MovingAverageView: View {
    @ObservedObject var viewModel: NewStrategyViewModel
    var typeOfStrategy: TypesOfStrategies
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var searchResultsList: some View {
        ForEach(viewModel.searchResults, id: \.self) { symbol in
            VStack {
                HStack {
                    Text(symbol.name)
                }.onTapGesture {
                    viewModel.selectedUnderlying = true
                    viewModel.underlyingEntry = symbol.name
                    UIApplication.shared.endEditing()
                }
            }
        }
    }
    
    var body: some View {
        let serviceError = Binding<Bool>(
            get: { self.viewModel.errorAlert  },
            set: { _ in self.viewModel.errorAlert = true }
        )
        ZStack {
            Form {
                Section(header: Text("Identifiers")) {
                    TextField("Underlying", text: $viewModel.underlyingEntry)
                }
                
                showEmptyOrList()
                
                Section(header: Text("Timeframe")) {
                    Picker("", selection: $viewModel.timeframeSelected) {
                        ForEach(0 ..< viewModel.timeframes.count) {
                            Text("\(viewModel.timeframes[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Action")) {
                    Picker("", selection: $viewModel.actionSelected) {
                        ForEach(0 ..< viewModel.strategyActions.count) {
                            Text("\(viewModel.strategyActions[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            
            VStack {
                Spacer()
                Button(action: {self.saveStrategyAndDismiss()}, label: {
                    Text("Save")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                    
                })
            }
        }
        .navigationBarTitle(Text(viewModel.strategyName))
        .alert(isPresented: serviceError) {
            Alert(title: Text("Error!"), message: Text("Cannot Save this strategy"), dismissButton: .default(Text("Dismiss")))
        }
        
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
        presentationMode.wrappedValue.dismiss()
        self.viewModel.saveStrategy()
    }
}

struct NewStrategyView_Previews: PreviewProvider {
    static var previews: some View {
        MovingAverageView(viewModel:NewStrategyViewModel(strategyName: "OK"),
                        typeOfStrategy: .GMMA)
        
    }
}
