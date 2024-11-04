//
//  LoginView.swift
//  Vitesse
//
//  Created by MacBook Air on 02/11/2024.
//

import SwiftUI

struct LoginView: View {
   
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // Image
                Image("Vitesse_P6")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .padding(.vertical, 32)
                
                
                // Form field
                VStack(spacing: 24) {
                    InputView(text: $username, title: "Email/Username", placeholder: "Enter your username")
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .autocorrectionDisabled(true)
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 15)
                // Forgot password
                NavigationLink(destination: ForgotPasswordView()) {
                Text("Forgot password?")
                .foregroundColor(.red)
                                }
                VStack(alignment: .center) {
                    // Sign Button
                    ButtonView(title: "Sign In", action: {
                        print("Sign In")
                    })
                    .padding(.top, 50)
                    .padding(.bottom, 25)
                    
                    // Register Button
                    NavigationLink(destination: RegistrationView()) {
                        Text("Register")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 200, height: 48)
                    }
                    .background(Color(.systemBlue))
                    .clipShape(.buttonBorder)
                                        }
                    
                    
                    
                   
                    Spacer()
                }
               
            }
        }
    }


#Preview {
    LoginView()
}
