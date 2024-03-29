//
//  CreateAccountViewModel.swift
//  Scalped
//
//  Created by Alexander Stevens on 1/28/21.
//

import Combine
import SwiftUI

class CreateAccountViewModel: ObservableObject {
    private var dataManager = CreateAccountDataManager()
    private var disposables = Set<AnyCancellable>()
    
    func submitNewAccount(with user: NewUser, accessCode: String, completion: @escaping ((Bool, String?) -> Void)) {
        self.dataManager.getCreateNewUserPublisher(user, accessCode: accessCode)
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
                    completion(true, nil)
                }
            })
            .store(in: &disposables)
    }
}
