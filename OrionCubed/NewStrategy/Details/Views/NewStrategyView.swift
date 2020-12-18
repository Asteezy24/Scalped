//
//  NewStrategyView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import SwiftUI

struct NewStrategyView: View {
    @ObservedObject var viewModel: NewStrategyViewModel
    @Binding var shouldPopToRootView : Bool
    var typeOfStrategy: TypesOfStrategies
    
    var commonViews: [AnyView] {
        switch typeOfStrategy {
        case .GMMA:
            return []
        case .yield:
            return []
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
    
    var body: some View {
        let serviceError = Binding<Bool>(
            get: { self.viewModel.errorAlert  },
            set: { _ in self.viewModel.errorAlert = true }
        )
        VStack {
            Form {
                Section(header: Text("Identifiers")) {
                    TextField("Underlying", text: $viewModel.underlyingEntry)
                }
                
                showEmptyOrList()
                
                //common views
                ForEach((0..<commonViews.count), id: \.self) { index in
                    commonViews[index]
                }

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
        self.shouldPopToRootView = false
        self.viewModel.saveStrategy()
    }
}

struct NewStrategyView_Previews: PreviewProvider {
    static var previews: some View {
        NewStrategyView(viewModel: NewStrategyViewModel(strategyName: "OK", strategyList: .constant([])), shouldPopToRootView: .constant(false), typeOfStrategy: .GMMA)
    }
}
