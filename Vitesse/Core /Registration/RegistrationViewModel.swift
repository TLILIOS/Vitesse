//
//  RegistrationViewModel.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 13/11/2024.
//
import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    @Published var confirmPassword: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var lastName: String = ""
    @Published var firstName: String = ""
    @Published var registrationSuccess = false
    @Published var errorMessage: String?
    @Published var showSuccessAlert = false // Propriété pour déclencher l'alerte
    
    var isFormValid: Bool {
            !email.isEmpty && !password.isEmpty && !firstName.isEmpty && !lastName.isEmpty && !confirmPassword.isEmpty
        }
    
    func register(email: String, password: String, firstName: String, lastName: String) {
        NetworkService.shared.performRequest(
            endpoint: .register(email: email, password: password, firstName: firstName, lastName: lastName),
            responseType: EmptyResponse.self
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.registrationSuccess = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
