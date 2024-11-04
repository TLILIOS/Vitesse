//
//  RegistrationView.swift
//  Vitesse
//
//  Created by MacBook Air on 03/11/2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    var body: some View {
        VStack {
            // Image
            Image("Vitesse_P6")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .padding(.vertical, 32)
            
            
            // Form field
            VStack(spacing: 24) {
                InputView(text: $firstName, title: "First Name", placeholder: "Enter your First Name")
                InputView(text: $lastName, title: "Last Name", placeholder: "Enter your Last Name")
                InputView(text: $email, title: "Email", placeholder: "Enter your Email")
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .autocorrectionDisabled(true)
                InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 15)
            ButtonView(title: "Create", action: {
                print("Create")
                
            })
            .padding(.top, 50)
            .padding(.bottom, 25)
            
            Spacer()
        }
    }
}

#Preview {
    RegistrationView()
}
