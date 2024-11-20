//
//  RegistrationView.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 03/11/2024.
//


import SwiftUI

struct RegistrationView: View {
    
    @StateObject private var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Champs de texte pour l'inscription
            InputView(label: "First Name", placeholder: "First Name", text: $viewModel.firstName)
            InputView(label: "Last Name", placeholder: "Last Name", text: $viewModel.lastName)
            InputView(label: "Email", placeholder: "Email", text: $viewModel.email)
            InputView(label: "Password", placeholder: "Password", text: $viewModel.password, isSecure: true)
            InputView(label: "Confirm Password", placeholder: "Confirm Password", text: $viewModel.confirmPassword, isSecure: true)
            
            // Bouton pour créer le compte
            Button("Create") {
                if viewModel.password == viewModel.confirmPassword {
                    viewModel.register(email: viewModel.email, password: viewModel.password, firstName: viewModel.firstName, lastName: viewModel.lastName)
                } else {
                    viewModel.errorMessage = "Passwords do not match"
                }
            }
            .disabled(!viewModel.isFormValid)
            .frame(maxWidth: .infinity)
            .padding()
            .background(viewModel.isFormValid ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(5)
            
            // Affichage d'un message d'erreur
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
            }
        }
        .padding()
        .navigationTitle("Register")
        .alert(isPresented: $viewModel.registrationSuccess) {
            Alert(title: Text("Success"), message: Text("Account created successfully!"), dismissButton: .default(Text("OK"), action: {
                dismiss()
            }))
        }
    }
}
