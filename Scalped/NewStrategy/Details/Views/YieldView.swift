//
//  YieldView.swift
//  Scalped
//
//  Created by Alexander Stevens on 1/10/21.
//

import SwiftUI

struct YieldView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: NewStrategyViewModel
    
    var searchResultsList: some View {
        ForEach(viewModel.searchResults, id: \.self) { symbol in
            VStack {
                HStack {
                    Text(symbol)
                    Spacer()
                }.onTapGesture {
                    self.viewModel.selectedUnderlying = true
                    self.viewModel.underlyingEntry = symbol
                    UIApplication.shared.endEditing()
                }
            }
        }
    }
    
    var underlyingSearchView: some View {
        if self.$viewModel.underlyingOptionSelected.wrappedValue == 0 {
            return AnyView(EmptyView())
        } else {
            return AnyView(
                TextField("Underlying", text: $viewModel.underlyingEntry))
        }
    }
    
    var body: some View {
        ZStack{
            Form {
                Section(header: Text("Underlying")) {
                    Picker("", selection: $viewModel.underlyingOptionSelected) {
                        ForEach(0 ..< viewModel.yieldUnderlyingOptions.count) { option in
                            Text("\(viewModel.yieldUnderlyingOptions[option])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    underlyingSearchView
                }
                showEmptyOrList()
                
                Section(header: Text("Buy Percentage")) {
                    VStack {
                        Slider(value: $viewModel.yieldBuyGoal, in: 0...100, step: 1)
                        Text("\(String(format: "%.0f", $viewModel.yieldBuyGoal.wrappedValue)) %")
                    }
                }
                Section(header: Text("Sell Goal")) {
                    VStack {
                        Slider(value: $viewModel.yieldSellGoal, in: 0...100, step: 1)
                        Text("\(String(format: "%.0f", $viewModel.yieldSellGoal.wrappedValue)) %")
                    }
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
        .navigationBarTitle("Yield")
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
        self.viewModel.saveYieldStrategy()
    }
}

struct YieldView_Previews: PreviewProvider {
    static var previews: some View {
        YieldView(viewModel: NewStrategyViewModel(strategyName: "Yield"))
    }
}
