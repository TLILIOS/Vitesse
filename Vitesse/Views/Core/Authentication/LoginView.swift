//
//  LoginView.swift
//  Vitesse
//
//  Created by TLiLi Hamdi on 02/11/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
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
                    NavigationLink(destination: ForgotPasswordView()){
                        Text("Forgot password?")
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 30)
                
                VStack(spacing: 50) {
                    NavigationLink {
                        AllCandidatesView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Sign in")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
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
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
