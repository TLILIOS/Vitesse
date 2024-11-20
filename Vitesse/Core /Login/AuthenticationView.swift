//
//  LoginView.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 02/11/2024.
//
import SwiftUI

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Champs de texte pour l'e-mail et le mot de passe
            InputView(label: "Email", placeholder: "Email", text: $viewModel.email)
            InputView(label: "Password", placeholder: "Password", text: $viewModel.password, isSecure: true)
            
            // Bouton de connexion
            Button("Sign in") {
                viewModel.authenticate(email: viewModel.email, password: viewModel.password)
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
            
            // Bouton pour aller à l'écran d'inscription
            NavigationLink(destination: RegistrationView()) {
                Text("Register")
                    .foregroundColor(.blue)
                    .padding(.top, 20)
            }
        }
        .padding()
        .navigationTitle("Login")
    }
}
