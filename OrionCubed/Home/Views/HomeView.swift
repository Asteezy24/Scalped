//
//  HomeView.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/14/20.
//

import SwiftUI
import Combine

var pub: AnyPublisher<(data: Data, response: URLResponse), URLError>? = nil
var sub: Cancellable? = nil
var data: Data? = nil
var response: URLResponse? = nil

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @State private var strategyDetailPresented = false
    
    func combineTest() {
        guard let url = URL(string: "https://apple.com") else {
            return
        }
        pub = URLSession.shared.dataTaskPublisher(for: url)
                .print("Test")
                .eraseToAnyPublisher()
        sub = pub?.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            },
            receiveValue: { data = $0.data; response = $0.response }
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Alerts")) {
                        ForEach(viewModel.alerts.reversed(), id: \.self) { alert in
                            HomeAlertItem(alert: alert)
                        }
                    }
                    Section(header: Text("Strategies")) {
                        ForEach(viewModel.strategies, id: \.self) { strategy in
                            HomeStrategyItem(strategy: strategy)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Orion Cubed")
                NavigationLink(destination: NewStrategyView(viewModel: NewStrategyViewModel(strategyList: viewModel.strategies))) {
                    Text("Add Strategy")
                }
            }
        }.onAppear {
           // combineTest()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
