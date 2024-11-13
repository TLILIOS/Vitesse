//
//  RegistrationViewModel.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 13/11/2024.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var registrationSuccess = false
    @Published var errorMessage: String?

    func registerUser(email: String, password: String, firstName: String, lastName: String) {
        NetworkService.shared.registerUser(email: email, password: password, firstName: firstName, lastName: lastName) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.registrationSuccess = true
                case .failure(let error):
                    self.registrationSuccess = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
