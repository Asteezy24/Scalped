//
//  SignInViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/29/21.
//

import Combine
import SwiftUI

class SignInViewModel: ObservableObject {
    private var dataManager = SignInDataManager()
    private var disposables = Set<AnyCancellable>()
    
    func signIn(username: String, password: String, completion: @escaping ((Bool, String?) -> Void)) {
        self.dataManager.getSignInPublisher(username: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                default: break
                }
            }, receiveValue: { httpResponse in
                print(httpResponse)
                if httpResponse.error {
                    print("got error " + httpResponse.message)
                    completion(false, httpResponse.message)
                } else {
                    // success, no message
                    completion(true, nil)
                }
            })
            .store(in: &disposables)
    }
}
