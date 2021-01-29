//
//  CreateAccountViewModel.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 1/28/21.
//

import Combine
import SwiftUI

class CreateAccountViewModel: ObservableObject {
    private var dataManager = CreateAccountDataManager()
    private var disposables = Set<AnyCancellable>()
    
    func submitNewAccount(with user: NewUser, completion: @escaping ((Bool) -> Void)) {
        self.dataManager.getCreateNewUserPublisher(user)
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
                    completion(false)
                } else {
                    completion(true)
                }
            })
            .store(in: &disposables)
    }
}
