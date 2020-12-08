//
//  NewStrategyView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/16/20.
//

import SwiftUI

struct NewStrategyView: View {
    @State private var strategyName = ""
    @State private var underlying = ""
    @State private var assetSelected = false
    @State private var firstTrigger = ""
    @State private var secondTrigger = ""
    @State private var actionSelected = 0
    
    private let strategyActions = ["Buy", "Sell"]
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @Binding var strategyList: [Strategy]
    var viewModel: NewStrategyViewModel
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Identifiers")) {
                    TextField("Strategy Name", text: $strategyName)
                    TextField("Underlying", text: $underlying)
                }
                
                showEmptyOrList()
                
                Section(header: Text("Trigger")) {
                    VStack(alignment: .leading) {
                        Text("When the...")
                            .font(.body)
                        TextField("First trigger", text: $firstTrigger)
                            .padding(.horizontal, 16)
                            .keyboardType(.numberPad)
                    }
                    VStack(alignment: .leading) {
                        Text("Crosses the...")
                            .font(.body)
                        TextField("Second trigger", text: $secondTrigger)
                            .padding(.horizontal, 16)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section(header: Text("Action")) {
                    Picker("", selection: $actionSelected) {
                        ForEach(0 ..< strategyActions.count) {
                            Text("\(self.strategyActions[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Button(action: {self.saveStrategyAndDismiss()}, label: {
                Text("Save")
            })
        }.navigationBarTitle(Text("New Strategy"))
    }
    
    var searchResultsList: some View {
        List {
            ForEach(stocks.filter { available in
                return (self.underlying.isEmpty || self.assetSelected) ? false : available.uppercased().contains(self.underlying.uppercased())
            }, id: \.self) { stock in
                VStack {
                    HStack {
                        Text(stock)
                    }.onTapGesture {
                        self.underlying = stock
                        self.assetSelected = true
                        UIApplication.shared.endEditing()
                    }
                }
            }
        }
    }
    
    private func showEmptyOrList() -> some View {
        switch self.underlying.isEmpty && !self.assetSelected {
        case true:
            return AnyView(EmptyView())
        case false:
            return AnyView(searchResultsList)
        }
    }
    
    private func saveStrategyAndDismiss() {
        self.presentationMode.wrappedValue.dismiss()
        let strategy = Strategy(strategyName: strategyName, strategyUnderlying: underlying, action: strategyActions[actionSelected])
        self.viewModel.saveStrategy(strategy)
    }
}

struct NewStrategyView_Previews: PreviewProvider {
    static var previews: some View {
        NewStrategyView(viewModel: NewStrategyViewModel(strategyList: .constant([])))
    }
}
