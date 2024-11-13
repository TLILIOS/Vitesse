//
//  LoginViewModel.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 13/11/2024.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isAdmin = false
    @Published var errorMessage: String?

    func authenticate(email: String, password: String) {
        NetworkService.shared.authenticate(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.isAuthenticated = true
                    self.isAdmin = response.isAdmin
                case .failure(let error):
                    self.isAuthenticated = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

