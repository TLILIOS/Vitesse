//
//  RegistrationView.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 03/11/2024.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel() // Instance de RegistrationViewModel
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Register")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                InputView(label: "First Name", placeholder: "First Name", text: $firstName)
                InputView(label: "Last Name", placeholder: "Last Name", text: $lastName)
                InputView(label: "Email", placeholder: "Email", text: $email)
                InputView(label: "Password", placeholder: "Password", text: $password, isSecure: true)
                InputView(label: "Confirm Password", placeholder: "Confirm Password", text: $confirmPassword, isSecure: true)

                Button {
                    if password == confirmPassword {
                        viewModel.registerUser(email: email, password: password, firstName: firstName, lastName: lastName)
                    } else {
                        viewModel.errorMessage = "Passwords do not match"
                    }
                } label: {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                .disabled(email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty || confirmPassword.isEmpty) // Désactiver le bouton si les champs sont vides

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                }
                
                if viewModel.registrationSuccess {
                    Text("Registration Successful!")
                        .foregroundColor(.green)
                        .padding(.top, 10)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                dismiss() // Ferme la vue après 1.5 secondes
                            }
                        }
                }
            }
            .padding()
        }
    }
}

#Preview {
    RegistrationView()
}
