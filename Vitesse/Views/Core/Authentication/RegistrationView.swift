//
//  RegistrationView.swift
//  Vitesse
//
//  Created by MacBook Air on 03/11/2024.
//

// File: RegistrationView.swift
import SwiftUI

struct RegistrationView: View {
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
                    dismiss()
                } label: {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
            .padding()
        }
    }
}

#Preview {
    RegistrationView()
}
