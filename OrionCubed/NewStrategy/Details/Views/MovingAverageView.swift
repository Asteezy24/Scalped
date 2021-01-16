//
//  NewStrategyView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import SwiftUI

struct MovingAverageView: View {
    @ObservedObject var viewModel: NewStrategyViewModel    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var searchResultsList: some View {
        ForEach(viewModel.searchResults, id: \.self) { symbol in
            VStack {
                HStack {
                    Text(symbol)
                }.onTapGesture {
                    viewModel.selectedUnderlying = true
                    viewModel.underlyingEntry = symbol
                    UIApplication.shared.endEditing()
                }
            }
        }
    }
    
    var body: some View {
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
        self.viewModel.saveMovingAverageStrategy()
    }
}

struct NewStrategyView_Previews: PreviewProvider {
    static var previews: some View {
        MovingAverageView(viewModel:NewStrategyViewModel(strategyName: "OK"))
    }
}
