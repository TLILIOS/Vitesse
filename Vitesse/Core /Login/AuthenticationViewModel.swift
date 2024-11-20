//
//  LoginViewModel.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 13/11/2024.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated = false
    @Published var errorMessage: String?

    var isFormValid : Bool {
        !email.isEmpty && !password.isEmpty
    }

 
    func authenticate(email: String, password: String) {
        NetworkService.shared.performRequest(
            endpoint: .authenticate(email: email, password: password),
            responseType: AuthResponse.self
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let authResponse):
                    NetworkService.shared.setAuthToken(authResponse.token)
                    self?.isAuthenticated = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

