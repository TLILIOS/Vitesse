//
//  LoginView.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 02/11/2024.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel() // Instance de AuthenticationViewModel
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isAuthenticated = false // Pour rediriger après la connexion

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                InputView(label: "Email/Username", placeholder: "Username", text: $username)
                InputView(label: "Password", placeholder: "Password", text: $password, isSecure: true)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot password?")
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 30)
                
                VStack(spacing: 50) {
                    Button(action: {
                        viewModel.authenticate(email: username, password: password)
                    }) {
                        Text("Sign in")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                    .disabled(username.isEmpty || password.isEmpty) // Désactiver le bouton si les champs sont vides
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Register")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                }
                
                NavigationLink(
                    destination: AllCandidatesView().navigationBarBackButtonHidden(),
                    isActive: $isAuthenticated,
                    label: { EmptyView() }
                )
            }
            .padding()
            .onReceive(viewModel.$isAuthenticated) { isAuth in
                isAuthenticated = isAuth // Met à jour l’état en fonction de la réponse du ViewModel
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
